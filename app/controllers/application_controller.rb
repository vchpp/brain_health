class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery prepend: true
  before_action :set_locale, :count_visits, :set_visitor_cookie, :set_locale_cookie, :set_admin, :ensure_visitor, :sign_out_admin
  helper_method :current_visitor 

  def restricted_access
    render plain: "Access Denied: Your permissions are invalid."
    # flash.now[:alert] = "Not allowed, incorrect credentials"
  end

private
  require 'faker'
  
  def authenticate_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end
  
  def count_visits
    value = (cookies[:visits] || 0 ).to_i
    cookies[:visits] = (value + 1)
  end
  
  def set_admin
    if current_user.try(:admin?)
      cookies[:tid] = "0"
    end
  end

  # not currently used
  def sign_out_admin
    if current_user == nil && cookies[:tid] == '0'
    # handle admin signouts
      cookies[:tid] = rand(1001..99999999).to_s
    # elsif current_user && cookies[:tid] > '0'
    # # handle admin sign_ins after navigating around
    #   cookies[:tid] = '0'
    end
  end
  
  def set_visitor_cookie
    if params[:tid].present? && params[:tid].to_i.between?(0,1000)
      cookies[:tid] ||= params[:tid]
    else
      cookies[:tid] ||= rand(1001..99999999).to_s
    end
  end
  
  def create_visitor
    @new_visitor = Visitor.new do |v|
      v.tid = cookies[:tid]
      v.name = Faker::Adjective.unique.positive + " " + Faker::Creature::Bird.unique.adjective + " " + Faker::Creature::Animal.unique.name
      v.avatar = Faker::Avatar.image(slug: cookies[:tid], size: "50x50")
    end
    @new_visitor.save
    flash.now[:notice] = "Welcome " + @new_visitor.name
  end

  def current_visitor
    @current_visitor ||= Visitor.find_by(tid: cookies[:tid])
  end

  def ensure_visitor
    if cookies[:tid].to_i.between?(1,1000)
      unless cookies[:tid] && Visitor.exists?(cookies[:tid])
        @current_visitor ||= create_visitor # Add attributes if needed
      end
    end
  end
  
  # set visitor on first browse, associate with TID cookie, flash welcome for visitor name
  # currently unused
  def check_visitor
    if cookies[:tid].to_i.between?(1,1000) #only create Visitors for allowed visitors
      # check if not admin
      if Visitor.where(tid: cookies[:tid]).first != nil
        # check if Visitor exists
        if Visitor.where(tid: cookies[:tid]).first.tid > '0'
          @current_visitor = Visitor.where(tid: cookies[:tid]).first
        end
      else 
        create_visitor
      end
    end
  end
  
  def check_cookie_value
    allowed_range = (0..1000)  # Define the acceptable range
    cookie_value = cookies[:tid].to_i  # Convert cookie to integer

    unless allowed_range.include?(cookie_value)
      reset_session  # Clear session to prevent unauthorized access
      logger.info "#{cookies[:tid]} tried to take an action, but was redirected."
      redirect_to restricted_access_path
    end
  end

  # sets the locale language within the route
  def set_locale
    I18n.locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0] || I18n.default_locale
  end

  def set_locale_cookie
    cookies[:locale] = params[:locale]
  end

  # allows for the router to add /language/ as a default route
  def default_url_options
    { locale: I18n.locale }
  end

  # pulls "accept-language" header and automatically finds locale
  def extract_locale
    parsed_locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : 'en'
  end

end
