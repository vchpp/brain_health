class AddSenderToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :sender, polymorphic: true, index: true, null: true
  end
end
