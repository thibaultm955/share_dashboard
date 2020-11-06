# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_05_205218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "scrape_urls", force: :cascade do |t|
    t.string "url"
    t.bigint "share_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["share_id"], name: "index_scrape_urls_on_share_id"
  end

  create_table "share_informations", force: :cascade do |t|
    t.date "date"
    t.float "share_price"
    t.float "variation"
    t.float "opening"
    t.float "highest"
    t.float "lowest"
    t.bigint "number_of_shares"
    t.bigint "share_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency"
    t.bigint "volume"
    t.bigint "market_cap"
    t.bigint "beta"
    t.bigint "pe"
    t.bigint "eps"
    t.index ["share_id"], name: "index_share_informations_on_share_id"
  end

  create_table "share_to_portfolios", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "share_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "price_objective"
    t.index ["portfolio_id"], name: "index_share_to_portfolios_on_portfolio_id"
    t.index ["share_id"], name: "index_share_to_portfolios_on_share_id"
  end

  create_table "shares", force: :cascade do |t|
    t.string "name"
    t.string "sector"
    t.string "country"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "mnemonic"
    t.string "market"
    t.string "industry"
    t.string "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "portfolios", "users"
  add_foreign_key "scrape_urls", "shares"
  add_foreign_key "share_informations", "shares"
  add_foreign_key "share_to_portfolios", "portfolios"
  add_foreign_key "share_to_portfolios", "shares"
end
