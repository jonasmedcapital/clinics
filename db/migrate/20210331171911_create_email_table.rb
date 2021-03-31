class CreateEmailTable < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_emails do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :account_id
      t.string :address
      t.integer :kind
      t.boolean :is_main
      t.text :notes
      t.bigint :company_id
      t.string :record_type
    end
      
    add_foreign_key :contact_emails, :account_entities, column: :account_id
    add_index :contact_emails, :account_id
    add_index :contact_emails, :address, unique: true
    add_index :contact_emails, :company_id
    add_index :contact_emails, :record_type
  end
end
