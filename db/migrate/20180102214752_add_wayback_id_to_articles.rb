include Wayback

class AddWaybackIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :wayback_id, :string
    Article.all.each do |a|
      a.wayback_id = get_wayback_id(a.url)
      a.save validate:false
    end
  end
end
