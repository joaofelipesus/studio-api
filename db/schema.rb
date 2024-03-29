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

ActiveRecord::Schema[7.0].define(version: 2022_10_16_215944) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "exercise_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "exercise_sequence"
    t.string "repetitions"
    t.string "rest"
    t.uuid "exercise_id", null: false
    t.uuid "exercises_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_schedules_on_exercise_id"
    t.index ["exercises_group_id"], name: "index_exercise_schedules_on_exercises_group_id"
  end

  create_table "exercise_workout_plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "workout_plan_id", null: false
    t.uuid "exercise_id", null: false
    t.integer "exercise_sequence"
    t.string "rest"
    t.string "repetitions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_workout_plans_on_exercise_id"
    t.index ["workout_plan_id"], name: "index_exercise_workout_plans_on_workout_plan_id"
  end

  create_table "exercises", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "muscular_group_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "personal_id"
    t.index ["muscular_group_id"], name: "index_exercises_on_muscular_group_id"
    t.index ["personal_id"], name: "index_exercises_on_personal_id"
  end

  create_table "exercises_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "workout_plan_id", null: false
    t.integer "execution_sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workout_plan_id"], name: "index_exercises_groups_on_workout_plan_id"
  end

  create_table "muscular_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objectives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "student_plan_id", null: false
    t.uuid "personal_id", null: false
    t.string "payment_method"
    t.date "date"
    t.decimal "amount", precision: 10, scale: 2
    t.index ["personal_id"], name: "index_payments_on_personal_id"
    t.index ["student_plan_id"], name: "index_payments_on_student_plan_id"
  end

  create_table "personals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_personals_on_user_id"
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.float "monthly_price"
    t.integer "duration_in_months"
    t.uuid "personal_id", null: false
    t.index ["personal_id"], name: "index_plans_on_personal_id"
  end

  create_table "schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_id", null: false
    t.string "status", default: "PENDING"
    t.uuid "personal_id", null: false
    t.uuid "workout_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "start_at"
    t.index ["personal_id"], name: "index_schedules_on_personal_id"
    t.index ["student_id"], name: "index_schedules_on_student_id"
    t.index ["workout_plan_id"], name: "index_schedules_on_workout_plan_id"
  end

  create_table "student_plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "plan_id", null: false
    t.uuid "student_id", null: false
    t.date "started_at"
    t.date "finished_at"
    t.string "status"
    t.string "payment_status", default: "PENDING", comment: "column with student_plan payment situation"
    t.index ["plan_id"], name: "index_student_plans_on_plan_id"
    t.index ["student_id"], name: "index_student_plans_on_student_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "personal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.uuid "objective_id"
    t.boolean "has_access", default: false
    t.uuid "user_id"
    t.index ["objective_id"], name: "index_students_on_objective_id"
    t.index ["personal_id"], name: "index_students_on_personal_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "status", default: "PENDING"
    t.string "name"
    t.string "confirmation_token"
    t.datetime "last_login", precision: nil
    t.datetime "confirmed_at", precision: nil
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workout_plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "personal_id", null: false
    t.string "name"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_id"], name: "index_workout_plans_on_personal_id"
  end

  add_foreign_key "exercise_schedules", "exercises"
  add_foreign_key "exercise_schedules", "exercises_groups"
  add_foreign_key "exercise_workout_plans", "exercises"
  add_foreign_key "exercise_workout_plans", "workout_plans"
  add_foreign_key "exercises", "muscular_groups"
  add_foreign_key "exercises_groups", "workout_plans"
  add_foreign_key "payments", "personals"
  add_foreign_key "payments", "student_plans"
  add_foreign_key "personals", "users"
  add_foreign_key "plans", "personals"
  add_foreign_key "schedules", "personals"
  add_foreign_key "schedules", "students"
  add_foreign_key "schedules", "workout_plans"
  add_foreign_key "student_plans", "plans"
  add_foreign_key "student_plans", "students"
  add_foreign_key "students", "personals"
  add_foreign_key "workout_plans", "personals"
end
