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

ActiveRecord::Schema[7.0].define(version: 2023_04_14_113357) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "international_phone_number"
    t.string "currency"
    t.string "country"
    t.string "city"
    t.string "identifier", null: false, comment: "External ID for reference"
    t.date "dob", null: false
    t.bigint "insurance_provider_id"
    t.datetime "discarded_at", comment: "Used for soft deletes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_customers_on_discarded_at"
    t.index ["dob"], name: "index_customers_on_dob"
    t.index ["first_name", "last_name", "dob"], name: "index_customers_on_first_name_and_last_name_and_dob"
    t.index ["first_name"], name: "index_customers_on_first_name"
    t.index ["identifier"], name: "index_customers_on_identifier"
    t.index ["insurance_provider_id"], name: "index_customers_on_insurance_provider_id"
    t.index ["last_name"], name: "index_customers_on_last_name"
  end

  create_table "insurance_providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false, comment: "External ID for reference"
    t.datetime "discarded_at", comment: "Used for soft deletes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_insurance_providers_on_discarded_at"
    t.index ["identifier"], name: "index_insurance_providers_on_identifier"
    t.index ["name"], name: "index_insurance_providers_on_name"
  end

  create_table "policies", force: :cascade do |t|
    t.integer "premium_cents", default: 0, null: false
    t.string "premium_currency", default: "USD", null: false
    t.integer "cover_cents", default: 0, null: false
    t.string "cover_currency", default: "USD", null: false
    t.string "identifier", null: false, comment: "External ID for reference"
    t.bigint "policy_type_id"
    t.bigint "customer_id"
    t.integer "status", default: 0, null: false
    t.date "effective_date"
    t.date "expiry_date"
    t.datetime "discarded_at", comment: "Used for soft deletes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_policies_on_customer_id"
    t.index ["discarded_at"], name: "index_policies_on_discarded_at"
    t.index ["expiry_date"], name: "index_policies_on_expiry_date"
    t.index ["identifier"], name: "index_policies_on_identifier"
    t.index ["policy_type_id"], name: "index_policies_on_policy_type_id"
  end

  create_table "policy_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "identifier", null: false, comment: "External ID for reference"
    t.datetime "discarded_at", comment: "Used for soft deletes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_policy_types_on_discarded_at"
    t.index ["identifier"], name: "index_policy_types_on_identifier"
    t.index ["name"], name: "index_policy_types_on_name"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.json "object"
    t.json "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "customers", "insurance_providers"
  add_foreign_key "policies", "customers"
  add_foreign_key "policies", "policy_types"
end
