class User::Account::Entity < ApplicationRecord
  include CpfValidates
  include Contacts
  extend FriendlyId
  friendly_id :token, use: :slugged

  self.table_name = "account_entities"

  attr_accessor :cpf_pretty

  # Relations
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true
  has_many :phones, class_name: "User::Contact::Phone", foreign_key: "account_id"
  has_many :emails, class_name: "User::Contact::Email", foreign_key: "account_id"
  has_many :addresses, class_name: "User::Contact::Address", foreign_key: "account_id"
  has_many :products, class_name: "Operation::Product::Entity", foreign_key: "account_id"
  has_one :product, class_name: "Operation::Account::Product", foreign_key: "account_id"
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: { message: "Por favor, insira o Nome. " }
  validates :sex, presence: { message: "Por favor, insira o Sexo. " }
  validate :cpf_validate, on: [:login, :create, :update]
  validates :cpf, presence: {message: "CPF não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "CPF já existe na base. "  }, on: [:create, :update]


  #Callbacks
  before_save :inactive_associations, on: [:update]
  
  #Enums
  enum sex: { male: 0,
              female: 1}, _prefix: :_

  
  def cpf_pretty
    ::AccountDecorator.new(self).cpf_pretty
  end

  def should_generate_new_friendly_id?
    self.token_changed?
  end

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
  
end

# create_table "account_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "user_id"
# t.string "name"
# t.string "cpf"
# t.string "kind", array: true
# t.string "slug"
# t.date "birthdate"
# t.text "notes"
# t.integer "sex"
# t.string "token"