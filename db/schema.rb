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

ActiveRecord::Schema.define(version: 2) do

  create_table "lineups", force: :cascade do |t|
    t.string "name"
    t.string "quarterback"
    t.string "runningback_one"
    t.string "runningback_two"
    t.string "widereceiver_one"
    t.string "widereceiver_two"
    t.string "widereceiver_three"
    t.string "tightend"
    t.string "flex"
    t.string "defense"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.integer "lineup_id"
  end

end
