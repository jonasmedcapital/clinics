class Operation::Account::Product < ApplicationRecord

  self.table_name = "operation_account_products"

  # Relations
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id"
  belongs_to :tax_filing, class_name: "Operation::Product::Entity", foreign_key: "tax_filing_id", optional: true
  belongs_to :tax_return, class_name: "Operation::Product::Entity", foreign_key: "tax_return_id", optional: true
  belongs_to :booking, class_name: "Operation::Product::Entity", foreign_key: "booking_id", optional: true
  belongs_to :billing, class_name: "Operation::Product::Entity", foreign_key: "billing_id", optional: true
  belongs_to :receivement, class_name: "Operation::Product::Entity", foreign_key: "receivement_id", optional: true
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id", optional: true

  #Enums
  

end



# create_table "operation_account_products", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "account_id"
# t.bigint "tax_return_id"
# t.bigint "booking_id"
# t.string "legal_ids", default: [], array: true
# t.bigint "billing_id"
# t.bigint "receivement_id"
# t.boolean "has_tax_return", default: false
# t.boolean "has_booking", default: false
# t.boolean "has_legal", default: false
# t.boolean "has_billing", default: false
# t.boolean "has_receivement", default: false
# t.bigint "tax_filing_id"
# t.bigint "banking_id"
# t.boolean "has_tax_filing", default: false
# t.boolean "has_banking", default: false