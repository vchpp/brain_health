class AddVisitorToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :visitor, foreign_key: true
  end
end
