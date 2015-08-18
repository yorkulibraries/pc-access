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

ActiveRecord::Schema.define(version: 20150818152255) do

  create_table "computers", force: :cascade do |t|
    t.string   "ip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "current_username"
    t.string   "previous_username"
    t.datetime "last_ping"
    t.integer  "location_id"
    t.datetime "last_keep_alive"
  end

  add_index "computers", ["location_id"], name: "index_computers_on_location_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "os_name"
    t.string   "os_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "map"
    t.string   "ip_subnet"
  end

end
