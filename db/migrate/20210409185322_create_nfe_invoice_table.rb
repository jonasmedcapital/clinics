class CreateNfeInvoiceTable < ActiveRecord::Migration[5.2]
  def change
    create_table :nfe_invoice_entities do |t|
      t.boolean :active, default: true, null: false
      t.timestamps
      t.bigint :clinic_id
      t.bigint :company_id
      t.bigint :receipt_id
      t.string :nfe_invoice_id
      t.integer :status
    end

    add_foreign_key :nfe_invoice_entities, :company_entities, column: :company_id
    add_foreign_key :nfe_invoice_entities, :product_entities, column: :clinic_id
    add_foreign_key :nfe_invoice_entities, :operation_clinic_receipts, column: :receipt_id
    add_index :nfe_invoice_entities, :clinic_id
    add_index :nfe_invoice_entities, :company_id
    add_index :nfe_invoice_entities, :nfe_invoice_id
    add_index :nfe_invoice_entities, :receipt_id
    add_index :nfe_invoice_entities, :status
  end
end
