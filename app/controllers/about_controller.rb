class AboutController < ApplicationController
  before_action :set_profiles, only: %i[ researchers ]
  # before_action :check_cookie_value, only: %i[ index researchers lhw cab_members ]

  def index
    @callouts = Callout.where(nil)
      .where(archive: false)
      .send("with_attached_#{I18n.locale}_image".downcase)
      .order('priority ASC')
  end

  def researchers
    @researchers
  end

  def lhw
    @lhw = Profile.where(archive: false).where(profile_type: 'Lay Health Worker').with_attached_headshot.order('lastname ASC')
  end

  def cab_members
    @cab_members = Profile.where(archive: false).where(profile_type: 'CAB Member').with_attached_headshot.order('lastname ASC')
  end

  private
    def set_profiles
      @profiles = Profile.where(archive: false).with_attached_headshot.order('lastname ASC')
      if @profiles.any?
        @researchers = []
        # @janice = @profiles.find_by(fullname: "Janice Tsoh")
        @sonia = @profiles.find_by(fullname: "Sonia Picht")
        @jiwon = @profiles.find_by(fullname: "JiWon Choi")
        @profiles.each do |profile|
          @researchers << profile if profile.profile_type == 'Research Team Member'
        end
        @researchers.delete(@sonia)
        @researchers.delete(@jiwon)
        # @researchers.delete(@janice)
        @researchers.unshift(@jiwon)
        @researchers.unshift(@sonia)
        # @researchers.unshift(@janice)
      end
    end

end
