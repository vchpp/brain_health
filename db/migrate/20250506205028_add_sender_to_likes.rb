class AddSenderToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :sender, polymorphic: true, index: true, null: true
  end
end
