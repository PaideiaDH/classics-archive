class AddBoilerpipeFields < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :boilerpipe_text, :string
  end
end
