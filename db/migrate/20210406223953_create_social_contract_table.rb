class CreateSocialContractTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_social_contracts do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.decimal :social_capital
      t.integer :shares
      t.text :social_object
      t.text :administration_clause
      t.text :profit_distribution
      t.integer :tax_regime
      t.integer :special_tax_regime
      t.integer :legal_nature
      t.string :registry_number
      t.string :regional_tax_number
      t.string :municipal_tax_number
    end

    add_foreign_key :operation_clinic_social_contracts, :product_entities, column: :clinic_id
    add_index :operation_clinic_social_contracts, :active
    add_index :operation_clinic_social_contracts, :clinic_id
    add_index :operation_clinic_social_contracts, :legal_nature
    add_index :operation_clinic_social_contracts, :municipal_tax_number
    add_index :operation_clinic_social_contracts, :regional_tax_number
    add_index :operation_clinic_social_contracts, :registry_number
    add_index :operation_clinic_social_contracts, :special_tax_regime
    add_index :operation_clinic_social_contracts, :tax_regime
  end
end
