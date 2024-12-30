class AddSlugToAdditionals < ActiveRecord::Migration[6.1]
  def change
    add_column :additionals, :slug, :string
    add_index :additionals, :slug, unique: true
  end
end
