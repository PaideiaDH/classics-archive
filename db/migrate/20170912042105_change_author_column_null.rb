class ChangeAuthorColumnNull < ActiveRecord::Migration[5.1]
  def up
    change_column_null :articles, :author_last_name, false
    change_column_null :articles, :author_first_name, false
    remove_column :articles, :author, :string
  end

  def down
    remove_column :articles, :author_first_name, :string
    remove_column :articles, :author_last_name, :string
    add_column :articles, :author, :string
  end
end
