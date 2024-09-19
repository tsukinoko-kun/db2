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

ActiveRecord::Schema[7.0].define(version: 2022_04_25_140431) do
  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "speed"
    t.integer "traction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laps", force: :cascade do |t|
    t.integer "duration"
    t.integer "player_id", null: false
    t.integer "race_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_laps_on_player_id"
    t.index ["race_id"], name: "index_laps_on_race_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "character_id", null: false
    t.integer "race_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_players_on_character_id"
    t.index ["race_id"], name: "index_players_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.datetime "started_at", precision: nil
    t.datetime "finished_at", precision: nil
    t.integer "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_races_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "laps", "players"
  add_foreign_key "laps", "races"
  add_foreign_key "players", "characters"
  add_foreign_key "players", "races"
  add_foreign_key "races", "tracks"
end
