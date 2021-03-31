class CreatePhoneTable < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_phones do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :account_id
      t.string :ddd
      t.string :number
      t.string :uniq_number
      t.integer :kind
      t.boolean :is_main
      t.text :notes
      t.bigint :company_id
      t.string :record_type
    end

    add_foreign_key :contact_phones, :account_entities, column: :account_id
    add_index :contact_phones, :account_id
    add_index :contact_phones, :company_id
    add_index :contact_phones, :record_type
    add_index :contact_phones, :uniq_number, unique: true
  end
end
