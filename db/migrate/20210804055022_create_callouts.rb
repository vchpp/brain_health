class CreateCallouts < ActiveRecord::Migration[6.1]
  def change
    create_table :callouts do |t|
      t.string :en_title
      t.string :en_body
      t.string :en_link_name
      t.string :ko_title
      t.string :ko_body
      t.string :ko_link_name
      t.string :link
      t.boolean :external_link
      t.boolean :archive
      t.string :tags, array:true, default:[]

      t.timestamps
    end
  end
end
