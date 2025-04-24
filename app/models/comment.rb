class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :visitor #, presence: true
  extend FriendlyId
  friendly_id :content, use: %i(slugged history finders)
  # validates :content, presence: true
  validates :tid, presence: true  #, inclusion: { in: (0..10000)}
  include Discard::Model

  def uplikes_count
    up = self.likes.map do |like| like.up end
    return up.map(&:to_i).reduce(0, :+)
  end
# likes.collect(:up)
  def downlikes_count
    down = self.likes.map do |like| like.down end
    return down.map(&:to_i).reduce(0, :+)
  end

  def self.to_csv
    attributes = %w{Created_at TID Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |comment|
        csv << [comment.created_at, comment.tid, comment.content, comment.commentable_type, comment.commentable_id]
      end
    end
  end

  def should_generate_new_friendly_id? #will change the slug if the content changed
    content_changed?
  end
end
