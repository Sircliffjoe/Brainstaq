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

ActiveRecord::Schema.define(version: 2024_06_02_180938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_details", force: :cascade do |t|
    t.datetime "subscribe_date"
    t.datetime "unsubscribe_date"
    t.datetime "expiry_date"
    t.integer "user_status"
    t.integer "pause_permit_count", default: 0
    t.datetime "pause_start_date"
    t.datetime "pause_cancel_date"
    t.integer "amount"
    t.boolean "recurring_billing"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "member_status"
    t.bigint "member_id"
    t.index ["member_id"], name: "index_account_details_on_member_id"
    t.index ["user_id"], name: "index_account_details_on_user_id"
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "business_plans", force: :cascade do |t|
    t.text "executive_summary"
    t.text "products_and_services"
    t.text "industry_analysis"
    t.text "competition"
    t.text "swot"
    t.text "operations"
    t.text "marketing"
    t.text "financial"
    t.text "appendices"
    t.text "milestones"
    t.text "vision"
    t.text "mission"
    t.text "objectives"
    t.text "value_proposition"
    t.integer "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.text "management"
    t.decimal "company_tax_rate", precision: 8, scale: 2
    t.decimal "bank_interest_rate", precision: 8, scale: 2
    t.integer "inflation_rate"
    t.integer "receivable_days"
    t.integer "payable_days"
    t.integer "inventory_days"
    t.integer "savings"
    t.integer "grants"
    t.integer "equity"
    t.integer "debt"
    t.integer "equity_injection_one"
    t.integer "equity_injection_two"
    t.integer "equity_injection_three"
    t.integer "equity_injection_four"
    t.integer "loan_year"
    t.integer "repayment_period"
    t.integer "raw_material_cost"
    t.integer "direct_labour_cost"
    t.integer "factory_overhead"
    t.integer "inbound_transport"
    t.integer "salaries_cost"
    t.integer "rent_cost"
    t.integer "utilities_cost"
    t.integer "marketing_cost"
    t.integer "admin_cost"
    t.integer "website_cost"
    t.integer "telephone_cost"
    t.integer "transport_cost"
    t.integer "misc"
    t.integer "land"
    t.integer "rent"
    t.integer "office_supplies"
    t.integer "equipment"
    t.integer "vehicles"
    t.integer "utilities"
    t.integer "opening_inventory"
    t.integer "capital"
    t.integer "contingency"
    t.decimal "dep_building"
    t.decimal "dep_furniture"
    t.decimal "dep_machinery"
    t.decimal "dep_installations"
    t.decimal "dep_vehicles"
    t.decimal "rent_cgr1"
    t.decimal "direct_cgr1"
    t.decimal "utilities_cgr1"
    t.decimal "marketing_cgr1"
    t.decimal "maintenance_cgr1"
    t.decimal "transport_cgr1"
    t.decimal "phone_cgr1"
    t.decimal "admin_cgr1"
    t.decimal "rent_cgr2"
    t.decimal "direct_cgr2"
    t.decimal "utilities_cgr2"
    t.decimal "marketing_cgr2"
    t.decimal "maintenance_cgr2"
    t.decimal "transport_cgr2"
    t.decimal "phone_cgr2"
    t.decimal "admin_cgr2"
    t.decimal "rent_cgr3"
    t.decimal "direct_cgr3"
    t.decimal "utilities_cgr3"
    t.decimal "marketing_cgr3"
    t.decimal "maintenance_cgr3"
    t.decimal "transport_cgr3"
    t.decimal "phone_cgr3"
    t.decimal "admin_cgr3"
    t.decimal "rent_cgr4"
    t.decimal "direct_cgr4"
    t.decimal "utilities_cgr4"
    t.decimal "marketing_cgr4"
    t.decimal "maintenance_cgr4"
    t.decimal "transport_cgr4"
    t.decimal "phone_cgr4"
    t.decimal "admin_cgr4"
    t.decimal "rent_cgr5"
    t.decimal "direct_cgr5"
    t.decimal "utilities_cgr5"
    t.decimal "marketing_cgr5"
    t.decimal "maintenance_cgr5"
    t.decimal "transport_cgr5"
    t.decimal "phone_cgr5"
    t.decimal "admin_cgr5"
    t.decimal "misc_cgr1"
    t.decimal "misc_cgr2"
    t.decimal "misc_cgr3"
    t.decimal "misc_cgr4"
    t.decimal "misc_cgr5"
    t.index ["enterprise_id"], name: "index_business_plans_on_enterprise_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "row_order"
    t.bigint "course_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "lessons_count", default: 0, null: false
    t.index ["course_id"], name: "index_chapters_on_course_id"
    t.index ["slug"], name: "index_chapters_on_slug", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.string "service_plan"
    t.integer "amount"
    t.string "payment_method"
    t.string "duration"
    t.string "brainstaq_transaction_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "username"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "idea_id"
    t.integer "user_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.bigint "lesson_id"
    t.index ["idea_id"], name: "index_comments_on_idea_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "course_categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "course_tags", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "tag_id", null: false
    t.index ["course_id"], name: "index_course_tags_on_course_id"
    t.index ["tag_id"], name: "index_course_tags_on_tag_id"
  end

  create_table "course_users", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.text "description"
    t.string "slug"
    t.string "image"
    t.string "handout"
    t.boolean "released", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "marketing_description"
    t.string "language", default: "English", null: false
    t.float "average_rating", default: 0.0, null: false
    t.integer "enrollments_count", default: 0, null: false
    t.integer "lessons_count", default: 0, null: false
    t.boolean "published", default: false
    t.boolean "approved", default: true
    t.integer "income", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.string "title"
    t.boolean "paid", default: false
    t.text "premium_description"
    t.integer "category_id"
    t.bigint "user_id", null: false
    t.string "level", default: "All levels", null: false
    t.integer "chapters_count", default: 0, null: false
    t.integer "course_category_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "donor_id", null: false
    t.integer "idea_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "response_reference"
    t.integer "perk_id"
    t.integer "user_id"
    t.index ["idea_id"], name: "index_donations_on_idea_id"
    t.index ["perk_id"], name: "index_donations_on_perk_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_donors_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating"
    t.integer "price"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["slug"], name: "index_enrollments_on_slug", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "enterprise_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.bigint "phone_number"
    t.bigint "integer"
    t.string "country"
    t.string "state"
    t.string "image"
    t.text "info"
    t.string "slug"
    t.integer "status"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "category_id"
    t.string "facebook_url"
    t.string "twitter_url"
    t.string "instagram_url"
    t.string "website_url"
    t.string "interval"
    t.index ["slug"], name: "index_enterprises_on_slug", unique: true
    t.index ["user_id"], name: "index_enterprises_on_user_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "subscription_plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscription_plan_id"], name: "index_features_on_subscription_plan_id"
  end

  create_table "financial_plans", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "company_tax_rate", precision: 8, scale: 2
    t.decimal "bank_interest_rate", precision: 8, scale: 2
    t.integer "inflation_rate"
    t.integer "salary_benefits"
    t.integer "receivable_days"
    t.integer "payable_days"
    t.integer "inventory_days"
    t.integer "savings"
    t.integer "grants"
    t.integer "equity"
    t.integer "debt"
    t.integer "equity_injection_one"
    t.integer "equity_injection_two"
    t.integer "equity_injection_three"
    t.integer "equity_injection_four"
    t.integer "user_id"
    t.index ["enterprise_id"], name: "index_financial_plans_on_enterprise_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "following_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id"], name: "index_followers_on_follower_id"
    t.index ["following_id"], name: "index_followers_on_following_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "ideas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.integer "total_comments", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "relevance_bar", default: 0
    t.string "slug"
    t.string "overview"
    t.string "challenges"
    t.string "impact"
    t.decimal "donation_goal", default: "0.0"
    t.integer "donated_amount", default: 0
    t.string "status", default: "active"
    t.integer "donations_count", default: 0
    t.date "end_date"
    t.integer "category_id"
    t.index ["slug"], name: "index_ideas_on_slug", unique: true
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "intro_tour_histories", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.bigint "user_id", null: false
    t.integer "touch_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "tour_id", "touch_count"], name: "index_intro_tour_histories_on_user_and_tour_and_touch_count"
  end

  create_table "intro_tours", force: :cascade do |t|
    t.string "ident", null: false
    t.string "controller_path", default: "", null: false
    t.string "action_name", default: "", null: false
    t.text "route"
    t.text "options"
    t.boolean "published", default: false
    t.datetime "expired_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["controller_path", "action_name", "published"], name: "index_intro_tours_on_controller_and_action_and_published"
    t.index ["ident"], name: "index_intro_tours_on_ident", unique: true
  end

  create_table "invoice_items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price"
    t.integer "qty"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "from_full_name"
    t.string "from_address"
    t.string "from_email"
    t.string "from_phone"
    t.string "to_full_name"
    t.string "to_address"
    t.string "to_email"
    t.string "to_phone"
    t.string "status"
    t.decimal "discount"
    t.decimal "vat"
    t.integer "user_id"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_invoices_on_enterprise_id"
  end

  create_table "lesson_users", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.boolean "completed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_lesson_users_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_users_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "row_order"
    t.integer "comments_count", default: 0, null: false
    t.integer "user_lessons_count", default: 0, null: false
    t.bigint "chapter_id"
    t.string "vimeo"
    t.index ["chapter_id"], name: "index_lessons_on_chapter_id"
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["slug"], name: "index_lessons_on_slug", unique: true
  end

  create_table "marketing_expenses", force: :cascade do |t|
    t.string "item_name"
    t.integer "cost"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_plan_id"], name: "index_marketing_expenses_on_business_plan_id"
  end

  create_table "members", force: :cascade do |t|
    t.integer "customer_code"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "phone_number"
    t.string "next_of_kin_email"
    t.string "address"
    t.date "date_of_birth"
    t.string "referal_name"
    t.bigint "payment_method_id"
    t.string "voucher_code"
    t.bigint "referring_customer_id"
    t.string "paystack_subscription_code"
    t.string "paystack_email_token"
    t.string "paystack_auth_code"
    t.string "paystack_cust_code"
    t.bigint "subscription_plan_id"
    t.text "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_code"], name: "index_members_on_customer_code", unique: true
    t.index ["email"], name: "index_members_on_email"
    t.index ["payment_method_id"], name: "index_members_on_payment_method_id"
    t.index ["phone_number"], name: "index_members_on_phone_number", unique: true
    t.index ["referring_customer_id"], name: "index_members_on_referring_customer_id"
    t.index ["subscription_plan_id"], name: "index_members_on_subscription_plan_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "milestone"
    t.string "done_by"
    t.integer "cost"
    t.date "date_schedule"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_plan_id"], name: "index_milestones_on_business_plan_id"
  end

  create_table "paystack_charges", force: :cascade do |t|
    t.datetime "paid_at"
    t.string "plan"
    t.integer "amount"
    t.string "channel"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_paystack_charges_on_created_at"
    t.index ["user_id"], name: "index_paystack_charges_on_user_id"
  end

  create_table "perks", force: :cascade do |t|
    t.string "title"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.text "description"
    t.integer "quantity"
    t.bigint "idea_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["idea_id"], name: "index_perks_on_idea_id"
  end

  create_table "pitch_decks", force: :cascade do |t|
    t.text "elevator_pitch"
    t.text "mission"
    t.text "problem"
    t.text "competitor_analysis"
    t.text "solution"
    t.text "how_it_works"
    t.text "market_opportunity"
    t.text "market_size"
    t.text "financials"
    t.text "revenue_model"
    t.text "traction"
    t.text "growth_strategy"
    t.integer "user_id"
    t.text "investment"
    t.text "team"
    t.text "introduction"
    t.text "conclusion"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_pitch_decks_on_enterprise_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "location"
    t.string "image"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_portfolios_on_enterprise_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "title"
    t.integer "number_of_employees_one"
    t.integer "number_of_employees_two"
    t.integer "number_of_employees_three"
    t.integer "base_annual_salary"
    t.integer "number_of_employees_four"
    t.integer "number_of_employees_five"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "image"
    t.text "bio"
    t.decimal "salary_benefits"
    t.decimal "salaries_cgr1"
    t.decimal "salaries_cgr2"
    t.decimal "salaries_cgr3"
    t.decimal "salaries_cgr4"
    t.decimal "salaries_cgr5"
    t.index ["business_plan_id"], name: "index_positions_on_business_plan_id"
  end

  create_table "products_and_growth_rates", force: :cascade do |t|
    t.string "product_name"
    t.text "description"
    t.string "product_image"
    t.integer "base_product_price"
    t.integer "monthly_sales_volume"
    t.integer "sales_volume_growth_rate_one"
    t.integer "unit_price_growth_rate_one"
    t.integer "sales_volume_growth_rate_two"
    t.integer "unit_price_growth_rate_two"
    t.integer "sales_volume_growth_rate_three"
    t.integer "unit_price_growth_rate_three"
    t.integer "sales_volume_growth_rate_four"
    t.integer "unit_price_growth_rate_four"
    t.integer "sales_volume_growth_rate_five"
    t.integer "unit_price_growth_rate_five"
    t.integer "sales_percentage_one"
    t.integer "sales_percentage_two"
    t.integer "sales_percentage_three"
    t.integer "sales_percentage_four"
    t.integer "sales_percentage_five"
    t.integer "sales_percentage_six"
    t.integer "sales_percentage_seven"
    t.integer "sales_percentage_eight"
    t.integer "sales_percentage_nine"
    t.integer "sales_percentage_ten"
    t.integer "sales_percentage_eleven"
    t.integer "sales_percentage_twelve"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_plan_id"], name: "index_products_and_growth_rates_on_business_plan_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.decimal "cost"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_plan_id"], name: "index_services_on_business_plan_id"
  end

  create_table "subs", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "status"
    t.string "interval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plan_name"
    t.integer "cost"
    t.string "description"
    t.boolean "recurring", default: false
    t.string "paystack_plan_code"
    t.integer "status", default: 0
    t.integer "duration"
    t.index ["paystack_plan_code"], name: "index_subscription_plans_on_paystack_plan_code", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subscription_plan_id", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "transaction_reference"
    t.string "plan_id"
    t.string "status"
    t.index ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "swots", force: :cascade do |t|
    t.string "swot_type"
    t.text "description"
    t.bigint "business_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_plan_id"], name: "index_swots_on_business_plan_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "course_tags_count", default: 0, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "channel"
    t.string "status"
    t.string "gateway_response"
    t.string "customer_code"
    t.string "currency"
    t.string "reference"
    t.bigint "amount"
    t.date "expires_on"
    t.bigint "integer"
    t.integer "enterprise_id"
  end

  create_table "user_lessons", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.integer "impressions", default: 0, null: false
    t.index ["lesson_id"], name: "index_user_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_user_lessons_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.text "bio"
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
    t.string "country"
    t.string "website"
    t.bigint "phone"
    t.string "gender"
    t.string "slug"
    t.string "image"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "admin", default: false
    t.string "facebook_url"
    t.string "twitter_url"
    t.string "instagram_url"
    t.string "linkedin_url"
    t.text "perk_subscriptions", default: [], array: true
    t.boolean "subscribed_to_plan"
    t.string "plan_subscription_id"
    t.string "plan"
    t.integer "status"
    t.string "interval"
    t.string "provider"
    t.string "uid"
    t.string "paystack_email_token"
    t.string "paystack_auth_code"
    t.string "paystack_cust_code"
    t.integer "courses_count", default: 0, null: false
    t.integer "enrollments_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "user_lessons_count", default: 0, null: false
    t.string "refresh_token"
    t.integer "expires_at"
    t.boolean "expires"
    t.integer "balance", default: 0, null: false
    t.integer "course_income", default: 0, null: false
    t.integer "enrollment_expenses", default: 0, null: false
    t.integer "enterprise_count", default: 0
    t.integer "business_plan_count", default: 0
    t.string "paystack_subscription_code"
    t.bigint "customer_code"
    t.bigint "subscription_plan_id"
    t.string "unconfirmed_email"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "stripe_customer_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["customer_code"], name: "index_users_on_customer_code", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["subscription_plan_id"], name: "index_users_on_subscription_plan_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "business_plans", "enterprises"
  add_foreign_key "charges", "users"
  add_foreign_key "course_tags", "courses"
  add_foreign_key "course_tags", "tags"
  add_foreign_key "donations", "perks"
  add_foreign_key "donors", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "financial_plans", "enterprises"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoices", "enterprises"
  add_foreign_key "lessons", "courses"
  add_foreign_key "marketing_expenses", "business_plans"
  add_foreign_key "milestones", "business_plans"
  add_foreign_key "paystack_charges", "users"
  add_foreign_key "perks", "ideas"
  add_foreign_key "pitch_decks", "enterprises"
  add_foreign_key "portfolios", "enterprises"
  add_foreign_key "positions", "business_plans"
  add_foreign_key "products_and_growth_rates", "business_plans"
  add_foreign_key "services", "business_plans"
  add_foreign_key "subscriptions", "subscription_plans", on_delete: :cascade
  add_foreign_key "subscriptions", "users", on_delete: :cascade
  add_foreign_key "swots", "business_plans"
  add_foreign_key "user_lessons", "lessons"
  add_foreign_key "user_lessons", "users"
end
