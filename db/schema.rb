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

ActiveRecord::Schema.define(version: 20140806172046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audio_clips", force: true do |t|
    t.string   "caption"
    t.integer  "beacon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "audio_file"
  end

  create_table "beacons", force: true do |t|
    t.integer  "minor_id"
    t.string   "content_type"
    t.integer  "installation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "major_id"
    t.string   "uuid"
    t.boolean  "active",                     default: false
    t.text     "location"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
    t.text     "content"
    t.string   "audio_url"
    t.string   "content_url"
    t.text     "description"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_code", default: "", null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
  end

  create_table "installations", force: true do |t|
    t.string   "name"
    t.string   "group"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             default: false
    t.string   "image_url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "installations", ["customer_id"], name: "index_installations_on_customer_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "url"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "beacon_id"
  end

  create_table "users", force: true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
