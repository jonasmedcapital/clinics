class CreateCompanyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :company_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :trade_name
      t.string :cnpj
      t.string :kind, array: true
      t.string :subkind, array: true
      t.string :slug
      t.date :opened_at
      t.text :notes
    end
    
      add_index :company_entities, :active
      add_index :company_entities, :cnpj, unique: true
      add_index :company_entities, :kind
      add_index :company_entities, :name
      add_index :company_entities, :slug, unique: true
      add_index :company_entities, :subkind
      add_index :company_entities, :trade_name
  end
end
