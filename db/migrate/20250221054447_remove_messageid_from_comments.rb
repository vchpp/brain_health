class RemoveMessageidFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :message_id, :bigint
  end
end
