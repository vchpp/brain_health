class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :en_post
      t.string :ko_post
      t.string :tags
      t.string :category
      t.boolean :featured
      t.boolean :archive
      t.integer :priority
      t.boolean :approved

      t.timestamps
    end
  end
end
