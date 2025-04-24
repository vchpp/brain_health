class Visitor < ApplicationRecord
  has_many :messages
  has_many :comments
end
