class Operation::Product::Entity < ApplicationRecord
  extend FriendlyId
  friendly_id :uniq_product, use: :slugged

  self.table_name = "product_entities"
  # default_scope -> {order(updated_at: :desc)}

  attr_accessor :kind_pretty, :product_name, :product_path, :token
  
  # Config Relations
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id", optional: true
  has_many :dates, class_name: "Product::Date", foreign_key: "product_id"

  # Config Receivements
  has_many :receivement_calculations, class_name: "Operation::Product::Receivement::Calculation", foreign_key: "receivement_id"
  has_many :papers, class_name: "Operation::Product::Receivement::Paper", foreign_key: "receivement_id"
  has_many :entries, class_name: "Operation::Product::Receivement::Entry", foreign_key: "receivement_id"
  has_many :transfers, class_name: "Operation::Product::Receivement::Transfer", foreign_key: "receivement_id"

  # Config TaxReturn
  has_many :tax_return_calculations, class_name: "Operation::Product::TaxReturn::Calculation", foreign_key: "tax_return_id"

  # Config TaxFiling
  has_many :tax_filing_calculations, class_name: "Operation::Product::TaxFiling::Calculation", foreign_key: "tax_filing_id"

  # Config Booking
  has_many :booking_calculations, class_name: "Operation::Product::Booking::Calculation", foreign_key: "booking_id"
  has_many :booking_receipts, class_name: "Operation::Product::Booking::Receipt", foreign_key: "booking_id"
  has_many :booking_payments, class_name: "Operation::Product::Booking::Payment", foreign_key: "booking_id"

  # Config Clinic
  has_many :clinic_takers, class_name: "Operation::Product::Clinic::Taker", foreign_key: "clinic_id"
  has_many :clinic_partners, class_name: "Operation::Product::Clinic::Partner", foreign_key: "clinic_id"

  # Validations
  validates :name, presence: { message: "Favor inserir o nome do Produto. " }
  validates :kind, presence: { message: "Favor inserir o tipo de Produto. " }
  validates :started_at, presence: { message: "Favor inserir o tipo de Produto. " }
  validates :uniq_product, uniqueness: { case_sensitive: false, message: "A Conta Produto já existe. " }

  # Enums
  enum name: { medclinic: 0, medpf: 1, medfat: 2, medseg: 3, medfin: 4, medreturn: 5, medbooking: 6, medfiling: 7, medreceivement: 8, medpayroll: 9 }, _prefix: :_
  enum kind: { receivement: 0, practice: 1 }, _prefix: :_
  enum status: { going: 0, onboard: 1, renewal: 2, blocked: 3, cancel: 4 }, _prefix: :_

  # Callbacks
  before_validation :set_uniq_product
  # after_find :set_attr_accessors
  after_create_commit :create_rooms


  def set_uniq_product
    if self.account_id
      account_code = self.account_id.to_s(36).rjust(4,"0").upcase
    else
      account_code = 0.to_s(36).rjust(4,"0").upcase
    end
    if self.company_id
      company_code = self.company_id.to_s(36).rjust(4,"0").upcase
    else
      company_code = 0.to_s(36).rjust(4,"0").upcase
    end

    name_code = self.defined_enums["name"][self.name]
    kind_code = self.defined_enums["kind"][self.kind]

    self.uniq_product = "#{account_code}#{company_code}#{name_code}#{kind_code}"
  end

  def refact_uniq_product
    set_uniq_product
    self.save
  end
  

  def set_attr_accessors
    self.product_name = ::Operations::Products::EntityRepository::ENUM_NAME[self.name]
    self.kind_pretty = ::Operations::Products::EntityRepository::ENUM_KIND[self.kind]
    self.product_path = ::Operations::Products::EntityRepository::PRODUCT_PATH[self.name][self.kind]
    self.token = self.uniq_product
  end

  def create_rooms
    # ::Operation::Message::Room.create!(obj_id: self.id, obj_type: self.class.name, name: "#{self.name} | #{self.kind}", kind: "product", room_type: "update")
    # ::Operation::Message::Room.create!(obj_id: self.id, obj_type: self.class.name, name: "#{self.name} | #{self.kind} Chat", kind: "product", room_type: "chat")
    # Operation::Message::Room.create!(obj_id: t.id, obj_type: t.class.name, name: "#{t.name} | #{t.kind} Chat", kind: "product", room_type: "chat")
  end
  
end


# create_table "product_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "blocked", default: false, null: false
# t.bigint "account_id"
# t.bigint "company_id"
# t.integer "name"
# t.integer "kind"
# t.string "uniq_product"
# t.decimal "amount", default: "0.0"
# t.date "started_at"
# t.integer "month_started_at"
# t.integer "year_started_at"
# t.text "notes"
# t.integer "status"
# t.string "slug"