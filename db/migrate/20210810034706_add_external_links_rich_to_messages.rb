class AddExternalLinksRichToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :en_external_rich_links, :string, default: nil
    add_column :messages, :ko_external_rich_links, :string, default: nil
  end
end
