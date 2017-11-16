class AddDataToDumpedLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :dumped_links, :rss_object, :json
    add_column :dumped_links, :title, :string, null: false
    add_column :dumped_links, :rejected, :boolean
  end
end
