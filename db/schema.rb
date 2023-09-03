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

ActiveRecord::Schema[7.0].define(version: 2023_08_24_081822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.integer "game_id"
    t.integer "current_player_id"
    t.boolean "is_active", default: true
    t.json "ready_players", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_messages", force: :cascade do |t|
    t.string "user"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealt_cards", force: :cascade do |t|
    t.integer "game_id"
    t.json "player1"
    t.json "player2"
    t.json "player3"
    t.json "table"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["player_id"], name: "index_game_players_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "creator_id"
    t.integer "player2_id"
    t.integer "player3_id"
    t.string "status"
    t.integer "duration"
    t.integer "buli"
    t.integer "ref_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games_players", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.index ["game_id"], name: "index_games_players_on_game_id"
    t.index ["player_id"], name: "index_games_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.string "email"
    t.integer "infractions", default: 0
    t.integer "chips", default: 0
    t.integer "rating", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
end
