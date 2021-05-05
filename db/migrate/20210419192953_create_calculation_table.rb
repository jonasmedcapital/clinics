class CreateCalculationTable < ActiveRecord::Migration[5.2]
  def change
    create_table :clinic_monthly_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.bigint :date_id
      t.integer :month
      t.integer :year
      t.decimal :gross_total
      t.decimal :net_receivable
      t.decimal :ir_total_amount
      t.decimal :pis_total_amount
      t.decimal :cofins_total_amount
      t.decimal :csll_total_amount
      t.decimal :inss_total_amount
      t.decimal :iss_total_amount
      t.decimal :ir_amount_withheld
      t.decimal :pis_amount_withheld
      t.decimal :cofins_amount_withheld
      t.decimal :csll_amount_withheld
      t.decimal :inss_amount_withheld
      t.decimal :iss_amount_withheld
      t.decimal :ir_amount_due
      t.decimal :csll_amount_due
      t.decimal :pis_amount_due
      t.decimal :cofins_amount_due
      t.decimal :iss_amount_due
      t.decimal :inss_amount_due
    end

    add_foreign_key :clinic_monthly_calculations, :product_entities, column: :clinic_id
    add_foreign_key :clinic_monthly_calculations, :product_dates, column: :date_id
    add_index :clinic_monthly_calculations, :clinic_id
    add_index :clinic_monthly_calculations, :date_id
    add_index :clinic_monthly_calculations, :month
    add_index :clinic_monthly_calculations, :year
  end
end
