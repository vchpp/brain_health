class Visitor < ApplicationRecord
  has_many :messages, as: :sender
  has_many :comments, as: :sender
  has_many :likes, as: :sender
end
