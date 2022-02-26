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

ActiveRecord::Schema.define(version: 2022_02_26_082937) do

  create_table "contacts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "address"
    t.string "gender"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "roles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_roles_on_slug", unique: true
  end

  create_table "shifts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.time "check_in", null: false
    t.time "check_out", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["check_in"], name: "index_shifts_on_check_in"
    t.index ["check_out"], name: "index_shifts_on_check_out"
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
    t.integer "starus"
    t.bigint "timesheet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["check_in"], name: "index_timesheets_on_check_in"
    t.index ["check_out"], name: "index_timesheets_on_check_out"
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
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "timesheet_details", "timesheets"
  add_foreign_key "timesheets", "shifts"
  add_foreign_key "timesheets", "users"
end
