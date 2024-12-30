class AddArchiveToAdditionals < ActiveRecord::Migration[6.1]
  def change
    add_column :additionals, :archive, :boolean, default: false
  end
end
