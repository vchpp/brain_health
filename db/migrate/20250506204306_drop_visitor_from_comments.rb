class DropVisitorFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :visitor, index: true, foreign_key: true
  end
end
