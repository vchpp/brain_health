class Board < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :tid, presence: true #, inclusion: { in: (0..10000)}

  extend FriendlyId
  friendly_id :en_post, use: %i(slugged history finders)
  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_search, -> (search) { where("en_post ilike ?", "%#{search}%").or(
                                        where("ko_post ilike ?", "%#{search}%")).or(
                                        where("category ilike ?", "%#{search}%")).or(
                                        where("array_to_string(tags,'||') ILIKE :en_post", en_post: "%#{search}%"))
                                        }
end
