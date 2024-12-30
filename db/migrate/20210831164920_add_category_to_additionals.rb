class AddCategoryToAdditionals < ActiveRecord::Migration[6.1]
  def change
    add_column :additionals, :category, :string, default: "general"
  end
end
