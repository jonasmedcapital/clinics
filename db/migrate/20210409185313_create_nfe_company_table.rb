class CreateNfeCompanyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :nfe_company_entities do |t|
      t.boolean :active, default: true, null: false
      t.timestamps
      t.bigint :clinic_id
      t.bigint :company_id
      t.string :nfe_company_id
    end
    
    add_foreign_key :nfe_company_entities, :company_entities, column: :company_id
    add_foreign_key :nfe_company_entities, :product_entities, column: :clinic_id
    add_index :nfe_company_entities, :clinic_id
    add_index :nfe_company_entities, :company_id
    add_index :nfe_company_entities, :nfe_company_id
  end
end
