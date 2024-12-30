class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :middlename
      t.string :middlename2
      t.string :lastname
      t.string :profile_type
      t.string :external_link
      t.string :en_project_title
      t.string :ko_project_title
      t.string :en_affiliation
      t.string :ko_affiliation
      t.string :en_bio
      t.string :ko_bio

      t.timestamps
    end
  end
end
