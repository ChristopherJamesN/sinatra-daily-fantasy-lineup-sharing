# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2) do
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
    t.string "password_digest"
    t.integer "lineup_id"
  end

end
