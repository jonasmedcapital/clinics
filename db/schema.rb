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

ActiveRecord::Schema.define(version: 2021_03_31_194856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "user_id"
    t.string "name"
    t.string "cpf"
    t.string "kind", array: true
    t.string "slug"
    t.date "birthdate"
    t.text "notes"
    t.integer "sex"
    t.string "token"
    t.index ["birthdate"], name: "index_account_entities_on_birthdate"
    t.index ["cpf"], name: "index_account_entities_on_cpf"
    t.index ["kind"], name: "index_account_entities_on_kind"
    t.index ["name"], name: "index_account_entities_on_name"
    t.index ["sex"], name: "index_account_entities_on_sex"
    t.index ["slug"], name: "index_account_entities_on_slug", unique: true
    t.index ["token"], name: "index_account_entities_on_token"
    t.index ["user_id"], name: "index_account_entities_on_user_id"
  end

  create_table "company_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "trade_name"
    t.string "cnpj"
    t.string "kind", array: true
    t.string "subkind", array: true
    t.string "slug"
    t.date "opened_at"
    t.text "notes"
    t.index ["active"], name: "index_company_entities_on_active"
    t.index ["cnpj"], name: "index_company_entities_on_cnpj", unique: true
    t.index ["kind"], name: "index_company_entities_on_kind"
    t.index ["name"], name: "index_company_entities_on_name"
    t.index ["slug"], name: "index_company_entities_on_slug", unique: true
    t.index ["subkind"], name: "index_company_entities_on_subkind"
    t.index ["trade_name"], name: "index_company_entities_on_trade_name"
  end

  create_table "contact_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "account_id"
    t.string "postal_code"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "ibge"
    t.integer "kind"
    t.boolean "is_main"
    t.text "notes"
    t.bigint "company_id"
    t.string "record_type"
    t.index ["account_id"], name: "index_contact_addresses_on_account_id"
    t.index ["city"], name: "index_contact_addresses_on_city"
    t.index ["company_id"], name: "index_contact_addresses_on_company_id"
    t.index ["postal_code"], name: "index_contact_addresses_on_postal_code"
    t.index ["record_type"], name: "index_contact_addresses_on_record_type"
    t.index ["state"], name: "index_contact_addresses_on_state"
  end

  create_table "contact_emails", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "account_id"
    t.string "address"
    t.integer "kind"
    t.boolean "is_main"
    t.text "notes"
    t.bigint "company_id"
    t.string "record_type"
    t.index ["account_id"], name: "index_contact_emails_on_account_id"
    t.index ["address"], name: "index_contact_emails_on_address", unique: true
    t.index ["company_id"], name: "index_contact_emails_on_company_id"
    t.index ["record_type"], name: "index_contact_emails_on_record_type"
  end

  create_table "contact_phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "account_id"
    t.string "ddd"
    t.string "number"
    t.string "uniq_number"
    t.integer "kind"
    t.boolean "is_main"
    t.text "notes"
    t.bigint "company_id"
    t.string "record_type"
    t.index ["account_id"], name: "index_contact_phones_on_account_id"
    t.index ["company_id"], name: "index_contact_phones_on_company_id"
    t.index ["record_type"], name: "index_contact_phones_on_record_type"
    t.index ["uniq_number"], name: "index_contact_phones_on_uniq_number", unique: true
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

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "cpf", default: "", null: false
    t.boolean "active", default: true, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "account_kind"
    t.integer "sex"
    t.string "token"
    t.boolean "blocked"
    t.datetime "blocked_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "last_sign_out_at"
    t.datetime "current_request_at"
    t.datetime "previous_request_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_kind"], name: "index_users_on_account_kind"
    t.index ["blocked"], name: "index_users_on_blocked"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sex"], name: "index_users_on_sex"
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "account_entities", "users"
  add_foreign_key "contact_addresses", "account_entities", column: "account_id"
  add_foreign_key "contact_emails", "account_entities", column: "account_id"
  add_foreign_key "contact_phones", "account_entities", column: "account_id"
end
