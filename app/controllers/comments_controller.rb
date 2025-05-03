class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index new show edit destroy ]
  before_action :check_cookie_value, only: %i[ new create edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.csv { send_data @comments.to_csv, filename: "Comments-#{Date.today}.csv" } if current_user.try(:admin?) 
    end
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @message = Message.friendly.find(params[:message_id]) if params[:message_id].present?
    @board = Board.friendly.find(params[:board_id]) if params[:board_id].present?
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.tid = cookies[:tid] || '0'
    @comment.visitor_id = @visitor.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: root_path, notice: "Thanks for your comment!" } 
        format.json { render :show, status: :created, location: @commentable }
        logger.info "Visitor with TID=#{cookies[:tid]} made a comment on message #{@commentable.id}, saying '#{@comment.content}'"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    if @comment.tid == cookies[:tid]
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_back fallback_location: root_path, notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_back fallback_location: root_path, alert: "Can't edit comment.  Action denied."
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if @comment.tid == cookies[:tid]
      @commentable = find_commentable
      logger.info "Visitor with TID=#{cookies[:tid]} deleted comment #{@commentable.id}, saying '#{@comment.content}'"
      @commentable.discard
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Comment was successfully deleted." }
        format.json { head :no_content }
      end
    else
      redirect_back fallback_location: root_path, alert: "Can't delete comment.  Action denied."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.friendly.find(params[:id])
    end

    def find_commentable
      if params[:comment_id]
        Comment.friendly.find(params[:comment_id])
      elsif params[:message_id]
        Message.friendly.find(params[:message_id])
      end
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
