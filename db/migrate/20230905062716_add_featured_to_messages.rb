class AddFeaturedToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :featured, :boolean, default: false
  end
end
