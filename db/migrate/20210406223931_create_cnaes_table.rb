class CreateCnaesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_cnaes do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.integer :kind
      t.string :cnae_code
      t.string :cnae_code_pretty
      t.string :cnae_description
    end

    add_foreign_key :operation_clinic_cnaes, :product_entities, column: :clinic_id
    add_index :operation_clinic_cnaes, :clinic_id
    add_index :operation_clinic_cnaes, :cnae_code
    add_index :operation_clinic_cnaes, :cnae_description
    add_index :operation_clinic_cnaes, :kind
  end
end
