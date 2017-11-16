class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :type_of, null: false, default: "article"
      t.string :image, null: false, default: "http://thelatinlanguage.org/wp-content/uploads/2013/05/logoGrouped.jpg"
      t.string :description, null: false, default: "an article shared by the Paideia Institute"
      t.string :site_name
      t.string :url, null: false
      t.datetime :published_time, null: false
      t.timestamps null: false
    end
  end
end
