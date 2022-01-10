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

ActiveRecord::Schema.define(version: 2022_01_09_135723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "system_terms", force: :cascade do |t|
    t.string "term", null: false
    t.string "pronunciation"
    t.string "definition"
    t.string "description"
    t.string "example"
    t.string "note"
    t.integer "level", null: false
    t.string "category", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index %w[term level], name: "index_system_terms_on_term_and_level"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.date "birthday"
    t.string "phone"
    t.string "role", null: false
    t.string "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
