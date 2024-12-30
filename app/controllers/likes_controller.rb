class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index new show edit destroy ]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.csv { send_data @likes.to_csv, filename: "Likes-#{Date.today}.csv" } if current_user.try(:admin?) 
    end
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @model = Message.friendly.find(params[:message_id]) if params[:message_id].present?
    @model = Faq.friendly.find(params[:faq_id]) if params[:faq_id].present?
    existing_likes = []
    @model.likes.each { |like| existing_likes.push(like.tid)}
    @like = @model.likes.new(like_params)
    @like.tid = cookies[:tid] || '0'
    if existing_likes.include?(@like.tid)
      logger.info "#{params[:tid]} tried to like a message a second time, but was redirected"
      redirect_to @model if params[:message_id].present?
      redirect_to @model if params[:faq_id].present?
    else
      respond_to do |format|
        if @like.save
          format.html { redirect_to @model, notice: "Thanks for the like!" } if params[:message_id].present?
          format.html { redirect_to @model, notice: "Thanks for the like!" } if params[:faq_id].present?
          format.json { render :show, status: :created, location: @model }
          logger.info "Visitor #{params[:tid]} liked message #{@model.id} with title #{@model.en_name}" if params[:message_id].present?
          logger.info "Visitor #{params[:tid]} liked FAQ #{@model.id} with title #{@model.en_question}" if params[:faq_id].present?
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @message, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:up, :down, :tid, :message_id, :faq_id)
    end
end
