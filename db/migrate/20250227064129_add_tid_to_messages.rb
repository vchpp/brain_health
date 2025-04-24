class AddTidToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :tid, :string, default: nil
  end
end
