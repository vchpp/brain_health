class Download < ApplicationRecord
  has_one_attached :en_file, dependent: :destroy
  has_one_attached :ko_file, dependent: :destroy
  scope :filter_by_search, -> (search) {(where("en_title ilike ?", "%#{search}%")).or(
                                         where("ko_title ilike ?", "%#{search}%")).or(
                                         where("array_to_string(tags,'||') ILIKE :en_title", en_title: "%#{search}%")).or(
                                         where("category ilike ?", "%#{search}%"))
                                       }
end
