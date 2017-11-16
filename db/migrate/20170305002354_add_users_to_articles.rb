class AddUsersToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :submitted_by, :integer
    add_column :articles, :approved_by, :integer
  end
end
