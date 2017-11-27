class AddLinkDump < ActiveRecord::Migration[5.1]
  def change
    create_table :dumped_links do |t|
      t.string :url, null: false
      t.string :submission_route, null: false
      t.timestamps null: false
    end
  end
end
