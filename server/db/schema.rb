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

ActiveRecord::Schema[8.0].define(version: 2025_06_12_080440) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.string "cv_level"
    t.string "email"
    t.datetime "last_applied_date"
    t.string "latest_status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_applicants_on_user_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "city"
    t.string "companies"
    t.string "email"
    t.datetime "first_applied_date"
    t.datetime "first_approved_date"
    t.string "fullname"
    t.string "phone_number"
    t.string "scanned_email"
    t.integer "latest_cv_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cvs", force: :cascade do |t|
    t.string "content"
    t.string "skill_tags"
    t.string "scanned_job_title"
    t.string "scanned_employer_names"
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.integer "status"
    t.integer "state"
    t.index ["applicant_id"], name: "index_cvs_on_applicant_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.bigint "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employees_on_employer_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "company_type"
    t.string "culture_description"
    t.datetime "deleted_at"
    t.string "email"
    t.integer "live_jobs_count"
    t.string "short_description"
    t.string "long_description"
    t.string "name"
    t.integer "page_views"
    t.boolean "overtime"
    t.integer "paid_jobs_count"
    t.integer "size"
    t.string "slug"
    t.string "website_url"
    t.string "country"
    t.integer "total_jobs_posted"
    t.integer "trial_jobs_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_applications", force: :cascade do |t|
    t.string "email"
    t.boolean "email_to_candidate_status"
    t.boolean "email_to_employer_status"
    t.string "fullname"
    t.bigint "cv_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "applicant_id"
    t.index ["applicant_id"], name: "index_job_applications_on_applicant_id"
    t.index ["cv_id"], name: "index_job_applications_on_cv_id"
    t.index ["job_id"], name: "index_job_applications_on_job_id"
  end

  create_table "job_candidates", force: :cascade do |t|
    t.datetime "accepted_at"
    t.datetime "invited_at"
    t.float "score"
    t.datetime "viewed_at"
    t.bigint "candidate_id"
    t.bigint "cv_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["candidate_id"], name: "index_job_candidates_on_candidate_id"
    t.index ["cv_id"], name: "index_job_candidates_on_cv_id"
    t.index ["job_id"], name: "index_job_candidates_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "address"
    t.string "description"
    t.integer "credit_type"
    t.string "employer_short_description"
    t.string "employer_long_description"
    t.string "employer_culture_description"
    t.string "employer_email"
    t.datetime "expired_at"
    t.integer "job_applications_count"
    t.datetime "published_at"
    t.string "question"
    t.string "salary"
    t.string "slug"
    t.string "title"
    t.string "status"
    t.bigint "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_jobs_on_employer_id"
  end

  create_table "user_job_applications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_user_job_applications_on_job_application_id"
    t.index ["user_id"], name: "index_user_job_applications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "fullname"
    t.string "phone"
    t.integer "sign_in_count"
    t.string "title"
    t.boolean "viewable_cv"
    t.integer "employer_id"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employer_id"], name: "index_users_on_employer_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
end
