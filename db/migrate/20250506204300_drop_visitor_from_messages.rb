class DropVisitorFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_reference :messages, :visitor, index: true, foreign_key: true
  end
end
