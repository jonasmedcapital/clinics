class User::Contact::Address < ApplicationRecord
  include Contacts

  self.table_name = "contact_addresses"

  # Relations
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id", optional: true

  # Validations
  # validate :is_main_uniq
  validates :record_type, presence: {message: "Favor insirar a Pessoa/Empresa. "}
  validates :kind, presence: {message: "Favor insirar o Tipo. "}
  validates :postal_code, presence: {message: "Favor insirar o CEP."},
                          format: { with: /\A\d+\z/, message: "Apenas números são permitidos no CEP."},
                          length: { in: 8..8, message: "CEP Inválido. " }
  validates :street, presence: {message: "Favor insirar a Rua."}
  validates :district, presence: {message: "Favor insirar o Bairro."}
  validates :city, presence: {message: "Favor insirar a Cidade."}
  validates :state, presence: {message: "Favor insirar o Estado."}
  validates :number, presence: {message: "Favor insirar o Número."},
                     format: { with: /\A\d+\z/, message: "Apenas números são permitidos."}
  validates :country, presence: {message: "Favor insirar o País."}
  # validates :ibge, presence: {message: "Favor insirar o Número IBGE."}


  # Enums
  enum kind: { personal: 0, commercial: 1 }, _prefix: :phone

  # Callbacks

  def to_name
    "Endereço"
  end

end


# datetime "created_at"
# datetime "updated_at"
# boolean "active"
# bigint "account_id"
# string "postal_code"
# string "street"
# string "number"
# string "complement"
# string "district"
# string "city"
# string "state"
# string "country"
# string "ibge"
# integer "kind"
# boolean "is_main"
# text "notes"
# bigint "company_id"
# string "record_type"