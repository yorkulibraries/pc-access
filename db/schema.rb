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

ActiveRecord::Schema.define(version: 20151006181245) do

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.string   "department"
    t.string   "map"
    t.text     "notes"
    t.boolean  "special_access", default: false, null: false
    t.boolean  "deleted",        default: false, null: false
    t.integer  "location_id"
    t.integer  "floor_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "computer_activity_logs", force: :cascade do |t|
    t.integer  "computer_id"
    t.string   "ip"
    t.datetime "activity_date"
    t.string   "action"
    t.string   "username"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "computers", force: :cascade do |t|
    t.string   "ip"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "current_username"
    t.string   "previous_username"
    t.datetime "last_ping"
    t.integer  "location_id"
    t.datetime "last_user_activity"
    t.integer  "area_id"
    t.boolean  "offline",            default: false, null: false
    t.string   "hostname"
    t.integer  "image_id"
    t.integer  "floor_id"
    t.string   "general_usage"
  end

  add_index "computers", ["location_id"], name: "index_computers_on_location_id"

  create_table "floors", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "deleted",     default: false, null: false
    t.string   "map"
    t.integer  "location_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "os_name"
    t.string   "os_version"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "deleted",    default: false, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "map"
    t.string   "ip_subnets"
    t.boolean  "active",     default: true,  null: false
    t.boolean  "deleted",    default: false, null: false
    t.integer  "floors"
    t.string   "address"
  end

end
