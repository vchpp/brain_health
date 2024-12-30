class Inspiration < ApplicationRecord
  scope :filter_by_search, -> (search) {(where("inspiration ilike ?", "%#{search}%")).or(
    where("array_to_string(tags,'||') ILIKE :inspiration", inspiration: "%#{search}%"))
  }
  scope :filter_by_lang, -> (lang) {(where("languages ilike?", "%#{lang}%"))}
end
