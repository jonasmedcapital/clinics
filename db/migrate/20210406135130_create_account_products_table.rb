class CreateAccountProductsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_account_products do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :account_id
      t.bigint :tax_return_id
      t.bigint :booking_id
      t.string :legal_ids, default: [], array: true
      t.bigint :billing_id
      t.bigint :receivement_id
      t.boolean :has_tax_return, default: false
      t.boolean :has_booking, default: false
      t.boolean :has_legal, default: false
      t.boolean :has_billing, default: false
      t.boolean :has_receivement, default: false
      t.bigint :tax_filing_id
      t.bigint :banking_id
      t.boolean :has_tax_filing, default: false
      t.boolean :has_banking, default: false
      t.boolean :has_clinic, default: false
      t.bigint :clinic_id
    end

    add_foreign_key :operation_account_products, :account_entities, column: :account_id
    add_foreign_key :operation_account_products, :product_entities, column: :tax_return_id
    add_foreign_key :operation_account_products, :product_entities, column: :booking_id
    add_foreign_key :operation_account_products, :product_entities, column: :billing_id
    add_foreign_key :operation_account_products, :product_entities, column: :receivement_id
    add_foreign_key :operation_account_products, :product_entities, column: :clinic_id
    add_index :operation_account_products, :account_id
    add_index :operation_account_products, :active
    add_index :operation_account_products, :banking_id
    add_index :operation_account_products, :billing_id
    add_index :operation_account_products, :booking_id
    add_index :operation_account_products, :has_banking
    add_index :operation_account_products, :has_billing
    add_index :operation_account_products, :has_booking
    add_index :operation_account_products, :has_legal
    add_index :operation_account_products, :has_receivement
    add_index :operation_account_products, :has_tax_filing
    add_index :operation_account_products, :has_tax_return
    add_index :operation_account_products, :legal_ids
    add_index :operation_account_products, :receivement_id
    add_index :operation_account_products, :tax_filing_id
    add_index :operation_account_products, :tax_return_id
    add_index :operation_account_products, :clinic_id
    add_index :operation_account_products, :has_clinic
  end
end
