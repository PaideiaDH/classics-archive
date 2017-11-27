class DownloadImages < ActiveRecord::Migration[5.0]
  def up
    remove_column :articles, :image
    add_attachment :articles, :image, null: false
    add_column :articles, :site_text, :string, null: false
    add_column :articles, :approved, :boolean, null: false
  end

  def down
    remove_attachment :articles, :image
    remove_column :articles, :site_text
    remove_column :articles, :approved
    add_column :articles, :image, :string, default: "http://thelatinlanguage.org/wp-content/uploads/2013/05/logoGrouped.jpg"
  end
end
