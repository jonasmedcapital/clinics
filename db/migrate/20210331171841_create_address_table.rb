class CreateAddressTable < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_addresses do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :account_id
      t.string :postal_code
      t.string :street
      t.string :number
      t.string :complement
      t.string :district
      t.string :city
      t.string :state
      t.string :country
      t.string :ibge
      t.integer :kind
      t.boolean :is_main
      t.text :notes
      t.bigint :company_id
      t.string :record_type
    end

    add_foreign_key :contact_addresses, :account_entities, column: :account_id
    add_index :contact_addresses, :account_id
    add_index :contact_addresses, :city
    add_index :contact_addresses, :company_id
    add_index :contact_addresses, :postal_code
    add_index :contact_addresses, :record_type
    add_index :contact_addresses, :state
  end
end
