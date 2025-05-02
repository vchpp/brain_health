class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ destroy ]
  before_action :set_page, only: [:show]
  before_action :check_cookie_value, only: %i[ new create index show edit update destroy]

  # GET /messages or /messages.json
  def index
    @messages = Message.where(nil)
      # .send("with_attached_#{I18n.locale}_images".downcase)
      .order("featured DESC NULLS LAST")
      .order("created_at DESC NULLS LAST")
    @admin_messages = @messages.sort_by(&:category)
    @messages = @messages.where(archive: false)
    set_message_categories
    @messages = @messages.filter_by_search(params[:search]) if (params[:search].present?)

    respond_to do |format|
      format.html
      format.csv { send_data @messages.to_csv, filename: "Messages-#{Date.today}.csv" } if current_user.try(:admin?)
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
    if @message.archive?
      if current_user.try(:admin?)
        flash.now[:alert] = "Message is currently archived"
      else
        redirect_to messages_url, alert: "Message not available."
      end
    end
    @likes = @message.likes.all.order('tid::integer ASC')
    @all_comments = @message.comments.includes(:likes, :visitor)
    @admin_comments = @all_comments.order('tid::integer ASC')
    @comments = @all_comments.order(created_at: :desc).limit(10).offset((@page.to_i - 1) * 10)
    @page_count = (@all_comments.count / 10) + 1
    up_likes
    down_likes

    respond_to do |format|
      format.html
      format.csv do
        if (params[:format_data] == 'comments')
          send_data @message.comments_to_csv, filename: "Message##{@message.id}-Comments-#{Date.today}.csv" if current_user.try(:admin?)
        elsif (params[:format_data] == 'likes')
          send_data @message.likes_to_csv, filename: "Message##{@message.id}-Likes-#{Date.today}.csv" if current_user.try(:admin?) 
        end
      end
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.visitor_id = @visitor.id || current_user.id
    @message.tid = cookies[:tid] || '0'
    @message[:tags] = params[:message][:tags].first.split("\r\n").map(&:strip) if params[:message][:tags].present?

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
        logger.info("#{@visitor.tid} created Message #{@message.id} with title #{@message.en_name}")
        # audit! :created_message, @message, payload: message_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    @message[:tags] = params[:message][:tags].first.split("\r\n").map(&:strip) if params[:message][:tags].present?

    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
        logger.info("#{@visitor.tid} updated Message #{@message.id} with title #{@message.en_name}")
        # audit! :updated_message, @message, payload: message_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    # audit! :destroyed_message, @message, payload: @message.attributes
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.friendly.find(params[:id]) #add 'with_attached_images' somehow?  Model?
  end

  def set_page
    @page = params[:page] || 1
  end

  def set_message_categories
    @message_categories = []
    @messages.each do |message|
      @message_categories << message.category
    end
    @message_categories = @message_categories.uniq
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:en_name,
                                    :en_content,
                                    :ko_name,
                                    :ko_content,
                                    :category,
                                    :tags,
                                    :tid,
                                    :archive,
                                    :featured,
                                    :priority,
                                  )
  end

  def up_likes
    likes = @message.likes.all
    up = likes.map do |like| like.up end
    @up_likes = up.map(&:to_i).reduce(0, :+)
  end

  def down_likes
    likes = @message.likes.all
    down = likes.map do |like| like.down end
    @down_likes = down.map(&:to_i).reduce(0, :+)
  end
  
  def coming_soon
    flash.now[:alert] = "#{t('messages.coming_soon')}"
  end
end
