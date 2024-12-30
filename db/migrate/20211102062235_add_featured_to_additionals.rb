class AddFeaturedToAdditionals < ActiveRecord::Migration[6.1]
  def change
    add_column :additionals, :featured, :boolean, default: false
  end
end
