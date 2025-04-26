class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery prepend: true
  before_action :set_locale, :count_visits, :set_admin, :set_visitor_cookie, :set_locale_cookie, :check_visitor
  
  def restricted_access
    render plain: "Access Denied: Your permissions are invalid."
    # flash.now[:alert] = "Action Denied: Your permissions are invalid."
  end

private
  require 'faker'
  
  def authenticate_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end
  
  def count_visits
    value = (cookies[:visits] || 0 ).to_i
    cookies[:visits] = (value + 1)
    # @visits = cookies[:visits]
  end
  
  def set_admin
    if current_user.try(:admin?)
      cookies[:tid] = 0
    end
  end
  
  def set_visitor_cookie
    if params[:tid].to_i.between?(1,9999)
      cookies[:tid] = {
        value: params[:tid],
        path: '/',
        SameSite: 'none',
        secure: 'true'
      }
    else
      cookies[:tid] ||= {
        value: rand(10001..99999999).to_s,
        path: '/',
        SameSite: 'none',
        secure: 'true'
      }
    end
  end

  def create_visitor
    @visitor = Visitor.new do |v|
      v.tid = cookies[:tid]
      v.name = Faker::Adjective.unique.positive + " " + Faker::Creature::Bird.unique.adjective + " " + Faker::Creature::Animal.unique.name
      v.avatar = Faker::Avatar.image(slug: cookies[:tid], size: "50x50")
    end
    @visitor.save
    @current_user = @visitor
    flash.now[:notice] = "Welcome " + @visitor.name
  end
  
  # set visitor on first browse, associate with TID cookie, flash welcome for visitor name
  def check_visitor
    # check if not admin
    if cookies[:tid].to_s > '0'
      # check if Visitor exists
      if Visitor.where(tid: cookies[:tid]).first != nil
        if Visitor.where(tid: cookies[:tid]).first.tid > '0'
          @current_user = Visitor.where(tid: cookies[:tid]).first
        end
      else 
        create_visitor
      end
    elsif @current_user == nil && cookies[:tid] == '0'
      # handle admin signouts
      cookies[:tid] ||= {
        value: rand(10001..99999999).to_s,
        path: '/',
        SameSite: 'none',
        secure: 'true'
      }
      create_visitor
    end
    p @current_user
    p cookies[:tid]
  end
  
  def check_cookie_value
    allowed_range = (0..1000)  # Define the acceptable range
    cookie_value = cookies[:tid].to_i  # Convert cookie to integer

    unless allowed_range.include?(cookie_value)
      reset_session  # Clear session to prevent unauthorized access
      logger.info "#{params[:tid]} tried to take an action, but was redirected."
      redirect_to restricted_access_path
      # redirect_back fallback_location: root_path, alert: "Action denied."
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
