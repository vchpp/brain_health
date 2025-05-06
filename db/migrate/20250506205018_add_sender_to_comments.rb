class AddSenderToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :sender, polymorphic: true, index: true, null: true
  end
end
