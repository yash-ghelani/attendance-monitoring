# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_26_163548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "session_attendances", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "timetabled_session_id", null: false
    t.index ["timetabled_session_id"], name: "index_session_attendances_on_timetabled_session_id"
    t.index ["user_id", "timetabled_session_id"], name: "index_session_attendances_on_user_id_and_timetabled_session_id", unique: true
    t.index ["user_id"], name: "index_session_attendances_on_user_id"
  end

  create_table "session_registered_lecturers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "timetabled_session_id", null: false
    t.index ["timetabled_session_id"], name: "index_session_registered_lecturers_on_timetabled_session_id"
    t.index ["user_id", "timetabled_session_id"], name: "session_registered_index", unique: true
    t.index ["user_id"], name: "index_session_registered_lecturers_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "timetabled_sessions", force: :cascade do |t|
    t.string "session_code"
    t.string "session_title"
    t.string "module_code"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "creator"
    t.string "report_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.boolean "admin"
    t.boolean "lecturer"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "session_attendances", "timetabled_sessions", on_delete: :cascade
  add_foreign_key "session_attendances", "users", on_delete: :cascade
  add_foreign_key "session_registered_lecturers", "timetabled_sessions", on_delete: :cascade
  add_foreign_key "session_registered_lecturers", "users", on_delete: :cascade
end
