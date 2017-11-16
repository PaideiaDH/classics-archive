class AddImageCreditToArticles < ActiveRecord::Migration[5.1]
  def up
    add_column :articles, :image_credit, :string, default: "NEEDS IMAGE CREDIT"
    change_column_null :articles, :image_credit, :false
  end
  def down
    remove_column :articles, :image_credit
  end
end
