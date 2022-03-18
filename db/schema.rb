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

ActiveRecord::Schema.define(version: 2022_03_14_143748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index %w[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index %w[blob_id variation_digest], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comment_votes", force: :cascade do |t|
    t.boolean "kind", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "term_comment_id"
    t.index ["term_comment_id"], name: "index_comment_votes_on_term_comment_id"
    t.index ["user_id"], name: "index_comment_votes_on_user_id"
  end

  create_table "course_sets", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_course_sets_on_course_id"
  end

  create_table "course_terms", force: :cascade do |t|
    t.string "term", null: false
    t.string "pronunciation"
    t.string "definition"
    t.string "description"
    t.string "example"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_set_id"
    t.index ["course_set_id"], name: "index_course_terms_on_course_set_id"
    t.index %w[term course_set_id], name: "index_course_terms_on_term_and_course_set_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.boolean "accepted", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "course_id"
    t.index ["course_id"], name: "index_members_on_course_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_notices_on_course_id"
  end

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

  create_table "term_comments", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "system_term_id"
    t.index ["system_term_id"], name: "index_term_comments_on_system_term_id"
    t.index ["user_id"], name: "index_term_comments_on_user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comment_votes", "term_comments"
  add_foreign_key "comment_votes", "users"
  add_foreign_key "course_sets", "courses"
  add_foreign_key "course_terms", "course_sets"
  add_foreign_key "courses", "users"
  add_foreign_key "members", "courses"
  add_foreign_key "members", "users"
  add_foreign_key "notices", "courses"
  add_foreign_key "term_comments", "system_terms"
  add_foreign_key "term_comments", "users"
end
