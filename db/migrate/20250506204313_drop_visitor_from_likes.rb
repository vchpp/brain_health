class DropVisitorFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :likes, :visitor, index: true, foreign_key: true
  end
end
