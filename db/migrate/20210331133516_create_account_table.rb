class CreateAccountTable < ActiveRecord::Migration[5.2]
  def change
    create_table :account_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :user_id
      t.string :name
      t.string :cpf
      t.string :kind, array: true
      t.string :slug
      t.date :birthdate
      t.text :notes
      t.integer :sex
      t.string :token
    end

    add_foreign_key :account_entities, :users, column: :user_id
    add_index :account_entities, :user_id
    add_index :account_entities, :slug, unique: true
    add_index :account_entities, :name
    add_index :account_entities, :cpf
    add_index :account_entities, :kind
    add_index :account_entities, :birthdate
    add_index :account_entities, :sex
    add_index :account_entities, :token
  end
end
