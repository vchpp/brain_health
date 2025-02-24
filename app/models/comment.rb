class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  # validates :content, presence: true
  validates :tid, presence: true  #, inclusion: { in: (0..10000)}

  def self.to_csv
    attributes = %w{Created_at TID Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |comment|
        csv << [comment.created_at, comment.tid, comment.content, comment.commentable_type, comment.commentable_id]
      end
    end
  end
end
