class AddAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :binary, default: "https://robohash.org/0.png?size=50x50&set=set1"
  end
end
