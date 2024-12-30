class CreateFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :faqs do |t|
      t.string :en_question
      t.string :ko_question
      t.string :category
      t.string :tags, array:true, default:[]

      t.timestamps
    end
  end
end
