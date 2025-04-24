class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.string :tid
      t.string :name, default: "Anonymous"
      t.binary :avatar

      t.timestamps
    end
  end
end
