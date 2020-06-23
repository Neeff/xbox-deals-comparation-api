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

ActiveRecord::Schema.define(version: 2020_06_14_175708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "iso"
    t.string "usd"
    t.string "clp"
    t.string "ars"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "details", force: :cascade do |t|
    t.bigint "sale_id"
    t.string "banner"
    t.text "description"
    t.string "clasification_image"
    t.string "clasification"
    t.string "c_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sale_id"], name: "index_details_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "status"
    t.string "name_game"
    t.string "old_price"
    t.string "new_price"
    t.string "link_to_xbox_site"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img"
    t.string "discount"
    t.string "currency"
    t.string "rating"
    t.string "data_bi_product"
    t.index ["name_game"], name: "index_sales_on_name_game", opclass: :gin_trgm_ops, using: :gin
  end

  add_foreign_key "details", "sales"
end
