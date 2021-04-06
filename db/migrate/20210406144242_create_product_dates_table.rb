class CreateProductDatesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :product_dates do |t|
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.integer :month
      t.integer :year
      t.string :uniq_product_date
      t.bigint :product_id
    end
    
    add_foreign_key :product_dates, :product_entities, column: :product_id
    add_index :product_dates, :month
    add_index :product_dates, :product_id
    add_index :product_dates, :uniq_product_date, unique: true
    add_index :product_dates, :year
    
  end
end
