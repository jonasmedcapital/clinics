class User::Contact::Email < ApplicationRecord
  include Contacts

  self.table_name = "contact_emails"

  # Relations
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id", optional: true

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :record_type, presence: {message: "Favor insirar a Pessoa/Empresa. "}
  validate :is_main_uniq
  validates :kind, presence: {message: "Favor insirar o Tipo. "}
  validates :address, presence: {message: "Por favor, insira o e-mail. "},
                    length: {maximum: 255, message: "Tamanho de e-mail inválido. "},
                    format: {with: VALID_EMAIL_REGEX, message: "E-mail inválido. "}

                    
  #Enums
  enum kind: { personal: 0, commercial: 1 }, _prefix: :_

  #Callbacks

  def to_name
    "E-mail"
  end

end


# create_table "contact_emails", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "account_id"
# t.string "address"
# t.integer "kind"
# t.boolean "is_main"
# t.text "notes"
# bigint "company_id"
# string "record_type"