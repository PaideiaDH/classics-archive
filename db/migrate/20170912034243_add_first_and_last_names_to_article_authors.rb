class AddFirstAndLastNamesToArticleAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :author_last_name, :string
    add_column :articles, :author_first_name, :string
    # change_column_null :articles, :author_last_name, false
    # change_column_null :articles, :author_first_name, false
  end

  # def down
    # remove_column :articles, :author_first_name, :string
    # remove_column :articles, :author_last_name, :string
  # end
end
