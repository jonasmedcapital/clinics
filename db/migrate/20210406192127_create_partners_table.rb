class CreatePartnersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_partners do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.bigint :account_id
      t.string :name
      t.string :cpf
      t.boolean :financial, default: false
      t.boolean :operational, default: false
      t.boolean :admnistrative, default: false
      t.boolean :doctor, default: false
      t.boolean :legal, default: false
      t.boolean :technical, default: false
      t.integer :shares
      t.date :entried_at
      t.date :exited_at
      t.text :exited_description
    end
    
    add_foreign_key :operation_clinic_partners, :product_entities, column: :clinic_id
    add_index :operation_clinic_partners, :account_id
    add_index :operation_clinic_partners, :active
    add_index :operation_clinic_partners, :admnistrative
    add_index :operation_clinic_partners, :clinic_id
    add_index :operation_clinic_partners, :cpf
    add_index :operation_clinic_partners, :doctor
    add_index :operation_clinic_partners, :financial
    add_index :operation_clinic_partners, :legal
    add_index :operation_clinic_partners, :name
    add_index :operation_clinic_partners, :operational
    add_index :operation_clinic_partners, :technical
  end
end
