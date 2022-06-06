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

ActiveRecord::Schema.define(version: 2022_04_06_102153) do

  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "address"
    t.string "gender"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_contacts_on_deleted_at"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "roles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
    t.index ["slug"], name: "index_roles_on_slug", unique: true
  end

  create_table "shifts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.time "check_in", null: false
    t.time "check_out", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["check_in"], name: "index_shifts_on_check_in"
    t.index ["check_out"], name: "index_shifts_on_check_out"
    t.index ["deleted_at"], name: "index_shifts_on_deleted_at"
  end

  create_table "timesheet_details", charset: "utf8mb3", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.integer "distance"
    t.decimal "accuracy", precision: 10
    t.string "ip_address"
    t.text "img"
    t.decimal "confidence", precision: 10
    t.text "note"
    t.integer "status"
    t.bigint "timesheet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_timesheet_details_on_deleted_at"
    t.index ["timesheet_id"], name: "index_timesheet_details_on_timesheet_id"
  end

  create_table "timesheets", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "check_in"
    t.datetime "check_out"
    t.string "location"
    t.integer "hours"
    t.integer "late"
    t.integer "status"
    t.text "note"
    t.bigint "user_id", null: false
    t.bigint "shift_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["check_in"], name: "index_timesheets_on_check_in"
    t.index ["check_out"], name: "index_timesheets_on_check_out"
    t.index ["deleted_at"], name: "index_timesheets_on_deleted_at"
    t.index ["shift_id"], name: "index_timesheets_on_shift_id"
    t.index ["user_id"], name: "index_timesheets_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.string "authentication_token", limit: 30
    t.datetime "deleted_at"
    t.string "provider"
    t.string "uid"
    t.string "accesstoken"
    t.string "refreshtoken"
    t.string "image"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contacts", "users"
  add_foreign_key "timesheet_details", "timesheets"
  add_foreign_key "timesheets", "shifts"
  add_foreign_key "timesheets", "users"
end
