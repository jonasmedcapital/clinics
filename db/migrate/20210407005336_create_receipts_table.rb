class CreateReceiptsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_receipts do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.bigint :date_id
      t.bigint :taker_id
      t.string :taker_type
      t.string :taker_name
      t.string :taker_federal_tax_number
      t.string :taker_municipal_tax_number
      t.string :taker_email
      t.string :taker_country
      t.string :taker_postal_code
      t.string :taker_street
      t.string :taker_number
      t.string :taker_complement
      t.string :taker_district
      t.string :taker_city_code
      t.string :taker_city_name
      t.string :taker_state
      t.string :city_service_code
      t.string :federal_service_code
      t.string :cnae_code
      t.string :description
      t.decimal :services_amount
      t.decimal :rps_serial_number
      t.date :issued_on
      t.integer :rps_number
      t.integer :taxation_type
      t.decimal :iss_rate
      t.decimal :iss_tax_amount
      t.decimal :deductions_amount
      t.decimal :unconditioned_amount
      t.decimal :conditioned_amount
      t.decimal :others_amount_withheld
      t.string :source
      t.string :version
      t.decimal :total_rate
      t.string :additional_information
      t.string :service_state
      t.string :service_city_code
      t.string :service_city_name
      t.decimal :ir_amount_withheld
      t.decimal :pis_amount_withheld
      t.decimal :cofins_amount_withheld
      t.decimal :csll_amount_withheld
      t.decimal :inss_amount_withheld
      t.decimal :iss_amount_withheld
      t.decimal :ir_total_amount
      t.decimal :pis_total_amount
      t.decimal :cofins_total_amount
      t.decimal :csll_total_amount
      t.decimal :inss_total_amount
      t.decimal :iss_total_amount
      t.decimal :ir_amount_due
      t.decimal :csll_amount_due
      t.decimal :pis_amount_due
      t.decimal :cofins_amount_due
      t.decimal :iss_amount_due
      t.decimal :inss_amount_due
      t.decimal :nominal_aliquot
      t.decimal :ir_aliquot
      t.decimal :csll_aliquot
      t.decimal :pis_aliquot
      t.decimal :cofins_aliquot
      t.decimal :inss_aliquot
      t.decimal :iss_aliquot
      t.decimal :effective_aliquot
      t.decimal :ir_effective_aliquot
      t.decimal :csll_effective_aliquot
      t.decimal :pis_effective_aliquot
      t.decimal :cofins_effective_aliquot
      t.decimal :inss_effective_aliquot
      t.decimal :iss_effective_aliquot
      t.decimal :total_due
      t.decimal :total_withheld
      t.decimal :total_withheld_parcial
      t.decimal :net_receivable
      t.integer :status
      t.string :tax_regime
      t.boolean :value_per_partner
      t.boolean :default_withheld
      t.boolean :iss_aliquot_check
      t.integer :payment_installments
    end

    add_foreign_key :operation_clinic_receipts, :product_dates, column: :date_id
    add_foreign_key :operation_clinic_receipts, :product_entities, column: :clinic_id
    add_index :operation_clinic_receipts, :clinic_id
    add_index :operation_clinic_receipts, :date_id
    add_index :operation_clinic_receipts, :default_withheld
    add_index :operation_clinic_receipts, :iss_aliquot_check
    add_index :operation_clinic_receipts, :issued_on
    add_index :operation_clinic_receipts, :service_city_code
    add_index :operation_clinic_receipts, :service_city_name
    add_index :operation_clinic_receipts, :status
    add_index :operation_clinic_receipts, :taker_federal_tax_number
    add_index :operation_clinic_receipts, :taker_type
    add_index :operation_clinic_receipts, :tax_regime
    add_index :operation_clinic_receipts, :value_per_partner
  end
end
