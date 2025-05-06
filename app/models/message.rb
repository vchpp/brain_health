class Message < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable
  has_rich_text :en_content
  has_rich_text :ko_content
  has_many :rich_texts,
    class_name: "ActionText::RichText",
    as: :record,
    inverse_of: :record,
    autosave: true,
    dependent: :destroy
  belongs_to :sender, polymorphic: true
  extend FriendlyId
  friendly_id :en_name, use: %i(slugged history finders)
  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_search, -> (search) { joins(:rich_texts).where("action_text_rich_texts.body ilike ?", "%#{search}%").or(
                                                            where("array_to_string(tags,'||') ILIKE :en_name", en_name: "%#{search}%")).or(
                                                            where("en_name ilike ?", "%#{search}%")).or(
                                                            where("category ilike ?", "%#{search}%")).uniq
                                                          }

  def self.to_csv
    attributes = %w{id
      created_at
      en_name
      en_content
      category
      archive}

    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |message|
        csv << attributes.map{ |attr| message.send(attr) }
      end
    end
  end

  def comments_to_csv
    attributes = %w{Created_at TID Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      if comments
        comments.each do |comment|
          csv << [comment.created_at, comment.tid, comment.content, comment.commentable_type, comment.commentable_id]
        end
      end
    end
  end

  def likes_to_csv
    attributes = %w{Created_at TID Uplikes Downlikes Type ID}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      if likes
        likes.each do |likes|
          csv << [likes.created_at, likes.tid, likes.up, likes.down, likes.likeable_type, likes.likeable_id]
        end
      end
    end
  end

  def should_generate_new_friendly_id? #will change the slug if the en_name changed
    en_name_changed?
  end
end
