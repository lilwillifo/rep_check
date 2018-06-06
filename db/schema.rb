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

ActiveRecord::Schema.define(version: 20180606174207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "bill_id"
    t.integer "roll_call"
    t.string "chamber"
    t.integer "year"
    t.integer "month"
    t.integer "congress"
    t.string "name"
    t.integer "session"
    t.string "democratic_majority_position"
    t.string "republican_majority_position"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_bills_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "representative_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["representative_id"], name: "index_favorites_on_representative_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "rep_votes", force: :cascade do |t|
    t.string "rep_name"
    t.bigint "bill_id"
    t.integer "vote_with", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["bill_id"], name: "index_rep_votes_on_bill_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.integer "district"
    t.string "name"
    t.string "facebook"
    t.string "twitter"
    t.string "email"
    t.string "website"
    t.string "bioguide_id"
    t.integer "party", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "screen_name"
    t.string "uid"
    t.string "oauth_token"
    t.string "oauth_token_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "bills", "categories"
  add_foreign_key "favorites", "representatives"
  add_foreign_key "favorites", "users"
  add_foreign_key "rep_votes", "bills"
end
