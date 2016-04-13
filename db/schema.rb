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

ActiveRecord::Schema.define(version: 20160413150936) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "company_id",  null: false
    t.integer  "customer_id", null: false
    t.integer  "event_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
  end

  create_table "contact_cards", force: :cascade do |t|
    t.string  "email"
    t.string  "phone"
    t.string  "street_address"
    t.string  "address_second_line"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "contactable_id",                      null: false
    t.string  "contactable_type",                    null: false
    t.boolean "main",                default: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "customers_events", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "company_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.string   "event_hall"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.datetime "date"
    t.integer  "room_id"
  end

  create_table "infos", force: :cascade do |t|
    t.string   "linen_colors"
    t.string   "napkin_colors"
    t.string   "napkin_fold"
    t.string   "placesetting"
    t.text     "centerpieces"
    t.string   "water_service"
    t.string   "coffee_service"
    t.integer  "final_guest_count"
    t.integer  "number_of_tables"
    t.integer  "guests_per_table"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id",                        null: false
    t.integer  "menu_option_id",                 null: false
    t.string   "course"
    t.float    "price_adjustment", default: 0.0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "menu_options", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.text     "description"
    t.string   "cuisine"
    t.float    "suggested_price_adjustment", default: 0.0
    t.string   "suggested_course"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "company_id",                 default: 0,   null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "service_style",  null: false
    t.string   "rate_type",      null: false
    t.float    "base_rate",      null: false
    t.float    "price_modifier"
    t.float    "final_price",    null: false
    t.integer  "event_id",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "message",      null: false
    t.string   "notable_type"
    t.integer  "notable_id"
    t.integer  "event_id",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string  "name"
    t.integer "company_id"
    t.integer "max_occupancy"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
