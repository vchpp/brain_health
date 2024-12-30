class CreateInspirations < ActiveRecord::Migration[6.1]
  def change
    create_table :inspirations do |t|
      t.string :inspiration
      t.string :tags, array:true, default: []
      t.string :languages
      t.string :category
      t.boolean :featured
      t.boolean :archive
      t.integer :priority

      t.timestamps
    end
  end
end
