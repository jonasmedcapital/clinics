class CreateTakersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_clinic_takers do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :clinic_id
      t.bigint :taker_id
      t.string :taker_type
      t.string :taker_number
      t.string :taker_name
    end

    add_foreign_key :operation_clinic_takers, :product_entities, column: :clinic_id
    add_index :operation_clinic_takers, :clinic_id
    add_index :operation_clinic_takers, :taker_id
    add_index :operation_clinic_takers, :taker_name
    add_index :operation_clinic_takers, :taker_number
    add_index :operation_clinic_takers, :taker_type
  end
end
