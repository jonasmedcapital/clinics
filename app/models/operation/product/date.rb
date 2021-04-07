class Operation::Product::Date < ApplicationRecord

  self.table_name = "product_dates"

  # Relations
  belongs_to :product, class_name: "Operation::Product::Entity", foreign_key: "product_id"
  has_many :receipts, class_name: "Operation::Product::Clinic::Receipt", foreign_key: "date_id"

  # Clinic Relations

  # Validations
  validates :product_id, presence: { message: "Falta definir o Produto. " }
  validates :uniq_product_date, uniqueness: { case_sensitive: false, message: "Período já existente. " }

  #Callbacks
  before_validation :set_uniq_product_date

  def set_uniq_product_date

    product_code = self.product_id.to_s(36).rjust(5,"0").upcase
    month_code = self.month.to_s.rjust(2,"0").upcase
    year_code = self.year.to_s.rjust(4,"0").upcase

    self.uniq_product_date = "#{product_code}#{year_code}#{month_code}"
  end
  
end

# create_table "product_dates", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "open", default: true, null: false
# t.integer "month"
# t.integer "year"
# t.string "uniq_product_date"
# t.bigint "product_id"