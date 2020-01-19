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

ActiveRecord::Schema.define(version: 20200115234116) do

  create_table "birders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "birds", force: :cascade do |t|
    t.string "common_name"
    t.string "latin_name"
    t.text   "description"
    t.string "image_url"
    t.string "grouping"
  end

  create_table "checklists", force: :cascade do |t|
    t.integer "birder_id"
    t.integer "location_id"
    t.integer "day_id"
    t.time    "start_time"
    t.time    "end_time"
    t.integer "temperature"
    t.string  "weather"
    t.string  "distance_travelled"
  end

  create_table "days", force: :cascade do |t|
    t.date "name"
  end

  create_table "locations", force: :cascade do |t|
    t.string  "name"
    t.string  "state"
    t.string  "country"
    t.integer "region_id"
  end

  create_table "rangemaps", force: :cascade do |t|
    t.integer "bird_id"
    t.integer "region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
  end

  create_table "sightings", force: :cascade do |t|
    t.integer "checklist_id"
    t.integer "bird_id"
  end

end
