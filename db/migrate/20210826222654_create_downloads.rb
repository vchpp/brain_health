class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads do |t|
      t.string :en_title
      t.string :en_file
      t.string :ko_title
      t.string :ko_file
      t.string :category
      t.boolean :archive
      t.string :tags, array:true, default:[]

      t.timestamps
    end
  end
end
