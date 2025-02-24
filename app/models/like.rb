class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  validates :tid, presence: true #, inclusion: { in: (0..10000)}

  def self.to_csv
    attributes = %w{Created_at TID Uplikes Downlikes Type ID}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |likes|
        csv << [likes.created_at, likes.tid, likes.up, likes.down, likes.likeable_type, likes.likeable_id]
      end
    end
  end
end
