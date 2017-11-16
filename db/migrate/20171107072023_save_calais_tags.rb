class SaveCalaisTags < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :calais_tags, :string, array: true, default: '{}'
  end
end
