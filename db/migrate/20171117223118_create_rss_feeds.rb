class CreateRssFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :rss_feeds do |t|
      t.string :name, null: false
      t.string :feed_url, null: false

      t.timestamps null: false
    end
  end
end
