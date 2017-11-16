class AddFeaturedToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :featured, :boolean
    add_column :articles, :featured_date, :datetime
  end
end
