# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160327231235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coach_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "num_accts"
    t.string   "billing_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        default: true
  end

  create_table "custom_exercises", force: true do |t|
    t.integer  "routine_id"
    t.string   "details"
    t.integer  "status"
    t.integer  "group_id"
    t.string   "name"
    t.integer  "ex_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_routines", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.date     "day_performed"
    t.integer  "weight"
    t.integer  "power_index"
    t.integer  "count_ex_provided"
    t.integer  "count_ex_completed"
    t.integer  "program_day_id"
    t.integer  "wt_day_id"
    t.integer  "sp_day_id"
    t.integer  "pl_day_id"
    t.integer  "wu_day_id"
    t.boolean  "modified"
    t.boolean  "pl_modified"
    t.boolean  "wt_modified"
    t.boolean  "wu_modified"
    t.boolean  "sp_modified"
    t.boolean  "changes_saved"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_routine_id"
    t.boolean  "shared",             default: false
  end

  create_table "day_exercises", force: true do |t|
    t.integer  "program_day_id"
    t.integer  "exercise_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercise_types", force: true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.integer  "exercise_type_id"
    t.string   "video_link"
    t.integer  "look_up_value"
    t.float    "percent_of_luv"
    t.integer  "category"
    t.integer  "difficulty"
    t.boolean  "is_body_weight"
    t.string   "name"
    t.boolean  "is_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.integer  "id_one"
    t.integer  "id_two"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_definitions", force: true do |t|
    t.integer  "order"
    t.text     "goal_text"
    t.text     "achieved_text"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goal_type"
  end

  create_table "group_custom_exercises", force: true do |t|
    t.integer  "routine_id"
    t.text     "details"
    t.integer  "status"
    t.string   "name"
    t.integer  "ex_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_joins", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_performed_exercises", force: true do |t|
    t.integer  "routine_id"
    t.integer  "exercise_id"
    t.integer  "status"
    t.integer  "exercise_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_performed_plyos", force: true do |t|
    t.integer  "plyometric_id"
    t.integer  "routine_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_performed_sprints", force: true do |t|
    t.integer  "sprint_id"
    t.integer  "status"
    t.integer  "routine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_performed_warmups", force: true do |t|
    t.integer  "routine_id"
    t.integer  "warmup_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_routines", force: true do |t|
    t.integer  "group_id"
    t.date     "day_performed"
    t.integer  "program_day_id"
    t.integer  "wt_day_id"
    t.integer  "sp_day_id"
    t.integer  "pl_day_id"
    t.integer  "wu_day_id"
    t.boolean  "modified"
    t.boolean  "pl_modified"
    t.boolean  "wt_modified"
    t.boolean  "wu_modified"
    t.boolean  "sp_modified"
    t.boolean  "changes_saved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_schedule_days", force: true do |t|
    t.integer  "group_schedule_id"
    t.boolean  "weights"
    t.boolean  "plyometrics"
    t.boolean  "stretching"
    t.boolean  "sprinting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
  end

  create_table "group_schedules", force: true do |t|
    t.integer  "group_id"
    t.integer  "program_id"
    t.date     "phase_one_start"
    t.date     "phase_two_start"
    t.date     "phase_three_start"
    t.date     "phase_four_start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "coach_user_id"
    t.string   "name"
    t.integer  "current_phase"
    t.integer  "sprint_diff",             default: 1
    t.integer  "last_weight_day_created", default: 0
    t.integer  "last_wu_day_created",     default: 0
    t.integer  "last_pl_day_created",     default: 0
    t.integer  "last_sp_day_created",     default: 0
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "laps", force: true do |t|
    t.integer  "lap_number"
    t.integer  "performed_sprint_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaders", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "value"
    t.integer  "type"
    t.date     "created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "liker"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "poster_id"
    t.text     "message"
    t.integer  "parent_id"
    t.integer  "to_id"
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "one_rep_maxes", force: true do |t|
    t.integer  "rep"
    t.float    "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performed_exercises", force: true do |t|
    t.integer  "routine_id"
    t.integer  "exercise_id"
    t.integer  "rest_period"
    t.integer  "status"
    t.integer  "one_rep_max"
    t.integer  "group_performed_exercise_id"
    t.integer  "exercise_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performed_plyometrics", force: true do |t|
    t.integer  "plyometric_id"
    t.integer  "routine_id"
    t.integer  "status"
    t.integer  "group_performed_plyometric_id"
    t.boolean  "performed_one"
    t.boolean  "performed_two"
    t.boolean  "performed_three"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performed_sprints", force: true do |t|
    t.integer  "sprint_id"
    t.integer  "status"
    t.integer  "group_performed_sprint_id"
    t.integer  "routine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performed_warm_ups", force: true do |t|
    t.integer  "routine_id"
    t.integer  "warmup_id"
    t.integer  "status"
    t.integer  "group_warmup_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phases", force: true do |t|
    t.integer  "male_power_sets"
    t.integer  "male_power_reps"
    t.integer  "male_other_sets"
    t.integer  "male_other_reps"
    t.integer  "fem_power_sets"
    t.integer  "fem_power_reps"
    t.integer  "fem_other_sets"
    t.integer  "fem_other_reps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plyometrics", force: true do |t|
    t.string   "name"
    t.string   "video_link"
    t.text     "recommended"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pod_invites", force: true do |t|
    t.integer  "inviter"
    t.string   "sent_to"
    t.integer  "status"
    t.integer  "invitee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_day_sequences", force: true do |t|
    t.integer  "program_id"
    t.integer  "number_of_days"
    t.integer  "one"
    t.integer  "two"
    t.integer  "three"
    t.integer  "four"
    t.integer  "five"
    t.integer  "six"
    t.integer  "seven"
    t.integer  "eight"
    t.integer  "nine"
    t.integer  "ten"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_days", force: true do |t|
    t.string   "day_enumeration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_phase_lookups", force: true do |t|
    t.integer  "phase_number"
    t.integer  "program_type"
    t.integer  "phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_types", force: true do |t|
    t.string   "program_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "program_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routine_messages", force: true do |t|
    t.integer  "daily_routine_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_codes", force: true do |t|
    t.string   "code"
    t.string   "receiver"
    t.boolean  "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_up_codes", force: true do |t|
    t.string   "code"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprint_detail_sequences", force: true do |t|
    t.integer  "sprint_id"
    t.integer  "detail_num"
    t.integer  "order_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprint_details", force: true do |t|
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprints", force: true do |t|
    t.integer  "difficulty"
    t.string   "name"
    t.integer  "sprint_type"
    t.integer  "num_laps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.integer  "exercise_type"
    t.text     "tip"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_goals", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_definition_id"
    t.json     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_maxes", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.float    "max"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_points", force: true do |t|
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "diff"
  end

  create_table "user_schedules", force: true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.integer  "program_type_id"
    t.date     "phase_one_start"
    t.date     "phase_two_start"
    t.date     "phase_three_start"
    t.date     "phase_four_start"
    t.date     "sign_up_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "master_user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "sex"
    t.boolean  "administrator"
    t.boolean  "sub_user"
    t.float    "knee_dom_max"
    t.float    "hor_push_max"
    t.float    "hor_pull_max"
    t.integer  "power_index"
    t.string   "old_password"
    t.integer  "current_phase"
    t.string   "phone"
    t.integer  "last_weight_day_created",     default: 0
    t.integer  "last_warmup_day_created",     default: 0
    t.integer  "last_plyometric_day_created", default: 0
    t.integer  "last_sprint_day_created",     default: 0
    t.string   "user_name"
    t.integer  "sprint_diff",                 default: 1
    t.float    "weight"
    t.integer  "level"
    t.integer  "program_type_id"
    t.integer  "birth_year"
    t.date     "subscription_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "experience_level"
    t.string   "displayed_user_name"
    t.integer  "points"
    t.json     "avatars"
    t.integer  "status",                      default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "warmups", force: true do |t|
    t.string   "name"
    t.boolean  "is_stretch"
    t.string   "video_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ex_type"
  end

  create_table "weekly_schedule_days", force: true do |t|
    t.integer  "day"
    t.integer  "user_schedule_id"
    t.boolean  "weights"
    t.boolean  "plyometrics"
    t.boolean  "stretching"
    t.boolean  "sprinting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weight_sets", force: true do |t|
    t.integer  "set_num"
    t.integer  "performed_exercise_id"
    t.float    "rec_weight"
    t.integer  "rec_reps"
    t.float    "perf_weight"
    t.integer  "perf_reps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workout_schedule_suggestions", force: true do |t|
    t.integer  "program_type"
    t.integer  "weight_schedule"
    t.integer  "program_id"
    t.integer  "num_weight_days"
    t.integer  "num_plyo_days"
    t.integer  "num_sprint_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
