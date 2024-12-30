class AdditionalsController < ApplicationController
  before_action :set_additional, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]

  # GET /additionals or /additionals.json
  def index
    @additionals = Additional.where(nil).order('en_title ASC') # creates an anonymous scope
    @admin_additionals = @additionals.sort_by(&:category)
    @additionals = @additionals.where(archive: false) # if current_user.try(:admin?)
    @additionals = @additionals.filter_by_search(params[:search]) if (params[:search].present?)
    @helplines, @mental_health_services, @education_materials, @classes_and_events, @community_resources, @covid_related, @other, @featured = [], [], [], [], [], [], [], []
    @additionals.each do |e|
      if e.featured == true
        @featured << e
        # 'helplines' 'mental Health Services' 'Education Materials' 'Classes and Events' 'Community Resources' 'COVID Related' 'other'
      elsif e.featured == false
        @helplines << e if e.category == "helplines"
        @mental_health_services << e if e.category == "mental_health_services"
        @education_materials << e if e.category == "education_materials"
        @classes_and_events << e if e.category == "classes_and_events"
        @community_resources << e if e.category == "community_resources"
        @covid_related << e if e.category == "covid_related"
        @other << e if e.category == "other"
      end
    end
    # @leftovers = @additionals.reject{|d| d.category == "general" || d.category == "other" || d.category == "self_care" || d.category == "strengthen_social_connections" || d.category == "cope_with_loss" || d.category == "help_yourself_help_others"}
  end

  # GET /additionals/1 or /additionals/1.json
  def show
    if @additional.archive?
      if current_user.try(:admin?)
        flash.now[:alert] = "Additional Resource is currently archived"
      else
        redirect_to additionals_url, alert: "Additional Resource not available."
      end
    end
  end

  # GET /additionals/new
  def new
    @additional = Additional.new
  end

  # GET /additionals/1/edit
  def edit
  end

  # POST /additionals or /additionals.json
  def create
    @additional = Additional.new(additional_params)
    @additional[:languages] = params[:additional][:languages].first.split("\r\n").map(&:strip)
    @additional[:tags] = params[:additional][:tags].first.split("\r\n").map(&:strip) if params[:additional][:tags].present?

    respond_to do |format|
      if @additional.save
        format.html { redirect_to @additional, notice: "Additional was successfully created." }
        format.json { render :show, status: :created, location: @additional }
        logger.info "#{current_user.email} created Additional (additional) Resource #{@additional.id} with title #{@additional.en_title}"
        audit! :created_additional, @additional, payload: additional_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /additionals/1 or /additionals/1.json
  def update
    @additional[:languages] = params[:additional][:languages].first.split("\r\n").map(&:strip)
    @additional[:tags] = params[:additional][:tags].first.split("\r\n").map(&:strip) if params[:additional][:tags].present?
    respond_to do |format|
      if @additional.update(additional_params)
        format.html { redirect_to @additional, notice: "Additional was successfully updated." }
        format.json { render :show, status: :ok, location: @additional }
        logger.info "#{current_user.email} updated Additional (additional) Resource #{@additional.id} with title #{@additional.en_title}"
        audit! :updated_additional, @additional, payload: additional_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additionals/1 or /additionals/1.json
  def destroy
    audit! :destroyed_additional, @additional, payload: @additional.attributes
    @additional.destroy
    respond_to do |format|
      format.html { redirect_to additionals_url, notice: "Additional was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_additional
      @additional = Additional.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def additional_params
      params.require(:additional).permit(:en_title, :en_source, :en_content, :en_external_link, :en_notes, :zh_tw_title, :zh_tw_source, :zh_tw_content, :zh_tw_external_link, :zh_tw_notes, :zh_cn_title, :zh_cn_source, :zh_cn_content, :zh_cn_external_link, :zh_cn_notes, :vi_title, :vi_source, :vi_content, :vi_external_link, :vi_notes, :hm_title, :hm_source, :hm_content, :hm_external_link, :hm_notes, :ko_title, :ko_source, :ko_content, :ko_external_link, :ko_notes, :languages, :last_version_date, :search, :category, :featured, :archive, :tags)
    end

    def hmong_coming_soon    
      if params[:locale] == "hm"
        flash.now[:alert] = "Cov khoom siv txhais lus hmoob yuav tawm saib saib tom ntej no"
      end
    end
end
