class User::Contact::Phone < ApplicationRecord
  include Contacts

  self.table_name = "contact_phones"

  # Relations
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id", optional: true

  # Validations
  validates :record_type, presence: {message: "Favor insirar a Pessoa/Empresa. "}
  # validate :is_main_uniq
  validates :kind, presence: {message: "Favor insirar o Tipo. "}
  validates :ddd, presence: {message: "Inválido. "},
                    length: { in: 2..2, message: "Inválido. " }
  validates :number, presence: {message: "Por favor, insira telefone válido. "},
                    length: { in: 8..9, message: "Formato errado do telefone. " }
  validates :uniq_number, uniqueness: {case_sensitive: false, message: "Telefone já existe na base. "},
                        presence: {message: "Por favor, insira telefone válido. "},
                        length: { in: 10..11, message: "Formato errado do telefone. " }

  # Enums
  enum kind: { personal: 0, commercial: 1 }, _prefix: :_

  # Callbacks

  def to_name
    "Telefone"
  end
  

end

# datetime "created_at"
# datetime "updated_at"
# boolean "active"
# bigint "account_id"
# string "ddd"
# string "number"
# string "uniq_number"
# integer "kind"
# boolean "is_main"
# text "notes"
# bigint "company_id"
# string "record_type"