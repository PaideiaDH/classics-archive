class AddGist < ActiveRecord::Migration[5.1]
  def change
    execute "CREATE INDEX text_similarity_idx ON articles USING gist (boilerpipe_text gist_trgm_ops);"
  end
end
