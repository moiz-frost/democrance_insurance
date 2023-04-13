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

ActiveRecord::Schema[7.0].define(version: 2023_04_13_195046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "international_phone_number"
    t.string "country"
    t.string "city"
    t.string "identifier", null: false, comment: "External ID for reference"
    t.date "dob", null: false
    t.bigint "insurance_providers_id"
    t.datetime "discarded_at", comment: "Used for soft deletes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_customers_on_discarded_at"
    t.index ["dob"], name: "index_customers_on_dob"
    t.index ["first_name", "last_name", "dob"], name: "index_customers_on_first_name_and_last_name_and_dob"
    t.index ["first_name"], name: "index_customers_on_first_name"
    t.index ["identifier"], name: "index_customers_on_identifier"
    t.index ["insurance_providers_id"], name: "index_customers_on_insurance_providers_id"
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

  add_foreign_key "customers", "insurance_providers", column: "insurance_providers_id"
end
