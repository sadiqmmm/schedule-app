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

ActiveRecord::Schema.define(version: 20170327024930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",                null: false
    t.string   "encrypted_password",     default: "",                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "position",               default: "General Manager"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "available_times", force: :cascade do |t|
    t.string   "day_of_week"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "admin_id"
    t.index ["admin_id"], name: "index_available_times_on_admin_id", using: :btree
  end

  create_table "employee_available_times", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "available_time_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["available_time_id"], name: "index_employee_available_times_on_available_time_id", using: :btree
    t.index ["employee_id"], name: "index_employee_available_times_on_employee_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "admin_id"
    t.string   "status",     default: "active"
    t.index ["admin_id"], name: "index_employees_on_admin_id", using: :btree
  end

  create_table "schedule_employees", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_schedule_employees_on_employee_id", using: :btree
    t.index ["schedule_id"], name: "index_schedule_employees_on_schedule_id", using: :btree
  end

  create_table "schedule_shifts", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "shift_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_schedule_shifts_on_schedule_id", using: :btree
    t.index ["shift_id"], name: "index_schedule_shifts_on_shift_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "business_year"
    t.integer  "business_week"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "admin_id"
    t.index ["admin_id"], name: "index_schedules_on_admin_id", using: :btree
  end

  create_table "shifts", force: :cascade do |t|
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id"
    t.string   "day_of_week"
  end

  add_foreign_key "available_times", "admins"
  add_foreign_key "employee_available_times", "available_times"
  add_foreign_key "employee_available_times", "employees"
  add_foreign_key "employees", "admins"
  add_foreign_key "schedule_employees", "employees"
  add_foreign_key "schedule_employees", "schedules"
  add_foreign_key "schedule_shifts", "schedules"
  add_foreign_key "schedule_shifts", "shifts"
  add_foreign_key "schedules", "admins"
end
