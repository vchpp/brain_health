class Callout < ApplicationRecord
  has_one_attached :en_image, dependent: :destroy
  has_one_attached :ko_image, dependent: :destroy
end
