# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150720124829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "merchants", ["name"], name: "index_merchants_on_name", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "merchant_id"
    t.string   "description"
    t.decimal  "price",       precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "products", ["description"], name: "index_products_on_description", using: :btree
  add_index "products", ["merchant_id"], name: "index_products_on_merchant_id", using: :btree

  create_table "purchasers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "purchasers", ["name"], name: "index_purchasers_on_name", using: :btree

  create_table "purchases", force: :cascade do |t|
    t.integer  "purchaser_id"
    t.integer  "product_id"
    t.integer  "count"
    t.decimal  "total_amount", precision: 12, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "purchases", ["product_id"], name: "index_purchases_on_product_id", using: :btree
  add_index "purchases", ["purchaser_id"], name: "index_purchases_on_purchaser_id", using: :btree

end
