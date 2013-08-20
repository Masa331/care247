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

ActiveRecord::Schema.define(version: 20130816124536) do

  create_table "desks", force: true do |t|
    t.string   "name",                            null: false
    t.string   "notificate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resolved_requests",   default: 0
    t.integer  "unresolved_requests", default: 0
    t.integer  "user_id",                         null: false
  end

  add_index "desks", ["user_id"], name: "index_desks_on_user_id"

  create_table "requests", force: true do |t|
    t.string   "name"
    t.string   "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "desk_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "zip_code"
    t.string   "country"
    t.string   "dic"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.boolean  "admin"
    t.string   "ic"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
