class CreateRegimeParameterTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_regime_parameters do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.boolean :monthly
      t.boolean :per_partner
      t.integer :tax_regime
      t.integer :special_tax_regime
      t.integer :legal_nature
      t.integer :year
      t.decimal :iss_rate
    end

    add_foreign_key :operation_clinic_regime_parameters, :product_entities, column: :clinic_id
    add_index :operation_clinic_regime_parameters, :clinic_id
    add_index :operation_clinic_regime_parameters, :per_partner
    add_index :operation_clinic_regime_parameters, :monthly
    add_index :operation_clinic_regime_parameters, :legal_nature
    add_index :operation_clinic_regime_parameters, :special_tax_regime
    add_index :operation_clinic_regime_parameters, :tax_regime
    add_index :operation_clinic_regime_parameters, :year
  end
end
