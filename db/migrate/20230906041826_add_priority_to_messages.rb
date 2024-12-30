class AddPriorityToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :priority, :integer, default: nil
  end
end
