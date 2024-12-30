class CreateAdditionals < ActiveRecord::Migration[6.1]
  def change
    create_table :additionals do |t|
      t.string :en_title
      t.string :en_source
      t.string :en_content
      t.string :en_external_link
      t.string :en_notes
      t.string :ko_title
      t.string :ko_source
      t.string :ko_content
      t.string :ko_external_link
      t.string :ko_notes
      t.string :languages, array: true, default: []
      t.string :tags, array:true, default:[]
      t.date :last_version_date

      t.timestamps
    end
  end
end
