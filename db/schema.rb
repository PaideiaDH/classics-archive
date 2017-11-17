# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171117223118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "type_of", default: "article", null: false
    t.string "description", default: "an article shared by the Paideia Institute", null: false
    t.string "site_name"
    t.string "url", null: false
    t.datetime "published_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", null: false
    t.string "image_content_type", null: false
    t.integer "image_file_size", null: false
    t.datetime "image_updated_at", null: false
    t.string "site_text", null: false
    t.boolean "approved", null: false
    t.integer "submitted_by"
    t.integer "approved_by"
    t.string "boilerpipe_text"
    t.string "image_credit", default: "NEEDS IMAGE CREDIT"
    t.string "author_last_name", null: false
    t.string "author_first_name", null: false
    t.boolean "featured"
    t.datetime "featured_date"
    t.string "calais_tags", default: [], array: true
    t.index "boilerpipe_text gist_trgm_ops", name: "text_similarity_idx", using: :gist
    t.index ["title"], name: "index_articles_on_title"
  end

  create_table "crono_jobs", force: :cascade do |t|
    t.string "job_id", null: false
    t.text "log"
    t.datetime "last_performed_at"
    t.boolean "healthy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "dumped_links", force: :cascade do |t|
    t.string "url", null: false
    t.string "submission_route", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "rss_object"
    t.string "title", null: false
    t.boolean "rejected"
    t.index ["title"], name: "index_dumped_links_on_title"
  end

  create_table "rss_feeds", force: :cascade do |t|
    t.string "name", null: false
    t.string "feed_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
  end

end
