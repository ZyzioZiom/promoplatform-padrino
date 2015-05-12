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

ActiveRecord::Schema.define(version: 12) do

  create_table "actions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "confirmed"
    t.string   "confirmation"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: :cascade do |t|
    t.string   "category"
    t.time     "hour"
    t.string   "day"
    t.date     "date"
    t.string   "place"
    t.string   "name"
    t.text     "description"
    t.integer  "points"
    t.string   "image"
    t.boolean  "global_talents"
    t.boolean  "global_citizen"
    t.boolean  "career_days"
    t.boolean  "career_forum"
    t.boolean  "future_leaders"
    t.boolean  "aiesec_university"
    t.boolean  "youth_to_business_forum"
    t.boolean  "global_host"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "points"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "who"
    t.string   "content"
    t.integer  "what"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "image"
  end

end
