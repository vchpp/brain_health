class Faq < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_rich_text :en_answer
  has_rich_text :ko_answer
  has_one_attached :en_audio, dependent: :destroy
  has_one_attached :ko_audio, dependent: :destroy
  has_many :rich_texts,
    class_name: "ActionText::RichText",
    as: :record,
    inverse_of: :record,
    autosave: true,
    dependent: :destroy
  extend FriendlyId
  friendly_id :en_question, use: %i(slugged history finders)
  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_search, -> (search) { joins(:rich_texts).where("action_text_rich_texts.body ilike ?", "%#{search}%").or(
                                         where("array_to_string(tags,'||') ILIKE :en_title", en_question: "%#{search}%")).or(
                                         where("en_question ilike ?", "%#{search}%")).or(
                                         where("ko_question ilike ?", "%#{search}%")).uniq
                                       }
end
