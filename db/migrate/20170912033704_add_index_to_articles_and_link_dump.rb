class AddIndexToArticlesAndLinkDump < ActiveRecord::Migration[5.1]
  def change
    add_index :dumped_links, :title
    add_index :articles, :title
  end
end
