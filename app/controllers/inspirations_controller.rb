class InspirationsController < ApplicationController
  before_action :set_inspiration, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create show edit update destroy ]

  # GET /inspirations or /inspirations.json
  def index
    @inspirations = Inspiration.where(nil).order('priority ASC') # creates an anonymous scope
    @admin_inspirations = @inspirations.sort_by(&:category)
    @inspirations = @inspirations.where(archive: false)
    @inspirations = @inspirations.filter_by_search(params[:search]) if (params[:search].present?)
    @inspirations = @inspirations.filter_by_lang(params[:lang]) if (params[:lang].present?)
    p "cookies[:tid] == #{cookies[:tid]}"
  end

  # GET /inspirations/1 or /inspirations/1.json
  def show
  end

  # GET /inspirations/new
  def new
    @inspiration = Inspiration.new
    @inspiration.priority = rand(1..999)
  end

  # GET /inspirations/1/edit
  def edit
  end

  # POST /inspirations or /inspirations.json
  def create
    @inspiration = Inspiration.new(inspiration_params)
    @inspiration[:tags] = params[:inspiration][:tags].first.split("\r\n").map(&:strip) if params[:inspiration][:tags].present?
    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to inspiration_url(@inspiration), notice: "Inspiration was successfully created." }
        format.json { render :show, status: :created, location: @inspiration }
        logger.info "#{current_user.email} created inspiration #{@inspiration.id} with title #{@inspiration.inspiration}"
        audit! :created_inspiration, @inspiration, payload: inspiration_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /inspirations/1 or /inspirations/1.json
  def update
    @inspiration[:tags] = params[:inspiration][:tags].first.split("\r\n").map(&:strip) if params[:inspiration][:tags].present?
    respond_to do |format|
      if @inspiration.update(inspiration_params)
        format.html { redirect_to inspiration_url(@inspiration), notice: "Inspiration was successfully updated." }
        format.json { render :show, status: :ok, location: @inspiration }
        logger.info "#{current_user.email} updated inspiration #{@inspiration.id} with title #{@inspiration.inspiration}"
        audit! :updated_inspiration, @inspiration, payload: inspiration_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspirations/1 or /inspirations/1.json
  def destroy
    @inspiration.destroy
    audit! :destroyed_inspiration, @inspiration, payload: @inspiration.attributes
    respond_to do |format|
      format.html { redirect_to inspirations_url, notice: "Inspiration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspiration
      @inspiration = Inspiration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inspiration_params
      params.require(:inspiration).permit(:inspiration, :tags, :languages, :category, :featured, :archive, :priority)
    end
end
