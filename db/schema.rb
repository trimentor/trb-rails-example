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

ActiveRecord::Schema.define(version: 20160302130044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "birthdays", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "event_id",  null: false
  end

  add_index "birthdays", ["event_id"], name: "index_birthdays_on_event_id", using: :btree
  add_index "birthdays", ["person_id", "event_id"], name: "index_birthdays_on_person_id_and_event_id", unique: true, using: :btree
  add_index "birthdays", ["person_id"], name: "index_birthdays_on_person_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.integer "person_id"
    t.string  "address",               null: false
    t.integer "category",  default: 0
  end

  add_index "emails", ["address"], name: "index_emails_on_address", using: :btree
  add_index "emails", ["category"], name: "index_emails_on_category", using: :btree
  add_index "emails", ["person_id"], name: "index_emails_on_person_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "location"
    t.datetime "start_time",  null: false
    t.datetime "end_time"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name",  null: false
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
