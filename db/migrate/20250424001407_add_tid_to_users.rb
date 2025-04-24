class AddTidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tid, :string, default: '0'
  end
end
