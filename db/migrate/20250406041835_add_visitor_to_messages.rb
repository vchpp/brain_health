class AddVisitorToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :visitor, foreign_key: true
  end
end
