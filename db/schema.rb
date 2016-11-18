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

ActiveRecord::Schema.define(version: 0) do

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "order_id",    limit: 4
    t.decimal  "unit_price",            precision: 12, scale: 3
    t.integer  "quantity",    limit: 4
    t.decimal  "total_price",           precision: 12, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_promotions", force: :cascade do |t|
    t.integer  "order_id",   limit: 4,   null: false
    t.integer  "promo_id",   limit: 4,   null: false
    t.string   "value",      limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_promotions", ["order_id"], name: "order_id", using: :btree
  add_index "order_promotions", ["promo_id"], name: "promotion_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",                  precision: 12, scale: 3
    t.decimal  "total_discount",            precision: 10, scale: 3, default: 0.0
    t.decimal  "total",                     precision: 12, scale: 3
    t.integer  "order_status_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "price",                  precision: 12, scale: 3
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name",        limit: 255,                 null: false
    t.string   "code",        limit: 255,                 null: false
    t.float    "value",       limit: 24,                  null: false
    t.string   "promo_type",  limit: 200,                 null: false
    t.boolean  "conjunction",             default: false, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 200, null: false
    t.string   "email",      limit: 250, null: false
    t.string   "address1",   limit: 255, null: false
    t.string   "cc_number",  limit: 100, null: false
    t.integer  "order_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["order_id"], name: "order_id", using: :btree

  add_foreign_key "order_items", "orders", name: "order_items_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_items", "products", name: "order_items_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_promotions", "orders", name: "order_promotions_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_promotions", "promotions", column: "promo_id", name: "order_promotions_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "orders", name: "users_ibfk_1", on_update: :cascade, on_delete: :cascade
end
