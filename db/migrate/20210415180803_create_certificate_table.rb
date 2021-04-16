class CreateCertificateTable < ActiveRecord::Migration[5.2]
  def change
    create_table :nfe_certificates do |t|
      t.boolean :active, default: true, null: false
      t.timestamps
      t.date :expiration_date
      t.integer :kind
      t.bigint :clinic_id
      t.string :password
    end

    add_foreign_key :nfe_certificates, :product_entities, column: :clinic_id
    add_index :nfe_certificates, :clinic_id
    add_index :nfe_certificates, :kind
  end
end
