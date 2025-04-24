class AddVisitorToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :visitor, foreign_key: true
  end
end
