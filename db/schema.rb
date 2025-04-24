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

ActiveRecord::Schema.define(version: 2025_04_24_040110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
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
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "additionals", force: :cascade do |t|
    t.string "en_title"
    t.string "en_source"
    t.string "en_content"
    t.string "en_external_link"
    t.string "en_notes"
    t.string "ko_title"
    t.string "ko_source"
    t.string "ko_content"
    t.string "ko_external_link"
    t.string "ko_notes"
    t.string "languages", default: [], array: true
    t.string "tags", default: [], array: true
    t.date "last_version_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "category", default: "general"
    t.boolean "featured", default: false
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_additionals_on_slug", unique: true
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "action", null: false
    t.bigint "user_id"
    t.bigint "record_id"
    t.string "record_type"
    t.text "payload"
    t.text "request"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["record_type", "record_id"], name: "index_audit_logs_on_record_type_and_record_id"
    t.index ["user_id", "action"], name: "index_audit_logs_on_user_id_and_action"
  end

  create_table "callouts", force: :cascade do |t|
    t.string "en_title"
    t.string "en_body"
    t.string "en_link_name"
    t.string "ko_title"
    t.string "ko_body"
    t.string "ko_link_name"
    t.string "link"
    t.boolean "external_link"
    t.boolean "archive"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "en_link_url"
    t.string "ko_link_url"
    t.integer "priority"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.string "tid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.string "slug"
    t.bigint "visitor_id"
    t.datetime "discarded_at"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["discarded_at"], name: "index_comments_on_discarded_at"
    t.index ["slug"], name: "index_comments_on_slug", unique: true
    t.index ["visitor_id"], name: "index_comments_on_visitor_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.string "en_title"
    t.string "en_file"
    t.string "ko_title"
    t.string "ko_file"
    t.string "category"
    t.boolean "archive"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "languages", default: [], array: true
  end

  create_table "faqs", force: :cascade do |t|
    t.string "en_question"
    t.string "ko_question"
    t.string "category"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_faqs_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "inspirations", force: :cascade do |t|
    t.string "inspiration"
    t.string "tags", default: [], array: true
    t.string "languages"
    t.string "category"
    t.boolean "featured"
    t.boolean "archive"
    t.integer "priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string "up", default: "0"
    t.string "down", default: "0"
    t.string "tid"
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["message_id"], name: "index_likes_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "en_name"
    t.string "en_content"
    t.string "ko_name"
    t.string "ko_content"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "en_action_item"
    t.string "ko_action_item"
    t.string "external_links", default: [], array: true
    t.string "slug"
    t.string "survey_link"
    t.string "en_external_rich_links"
    t.string "ko_external_rich_links"
    t.string "category", default: "general"
    t.boolean "archive", default: false
    t.boolean "featured", default: false
    t.integer "priority"
    t.string "tid"
    t.bigint "visitor_id"
    t.index ["slug"], name: "index_messages_on_slug", unique: true
    t.index ["visitor_id"], name: "index_messages_on_visitor_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "middlename2"
    t.string "lastname"
    t.string "profile_type"
    t.string "external_link"
    t.string "en_project_title"
    t.string "ko_project_title"
    t.string "en_affiliation"
    t.string "ko_affiliation"
    t.string "en_bio"
    t.string "ko_bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "fullname"
    t.string "external_links", default: [], array: true
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "tid", default: "0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visitors", force: :cascade do |t|
    t.string "tid"
    t.string "name", default: "Anonymous"
    t.binary "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "visitors"
  add_foreign_key "likes", "messages"
  add_foreign_key "messages", "visitors"
end
