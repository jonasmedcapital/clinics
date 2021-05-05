class Operation::Product::Clinic::MonthlyCalculation < ApplicationRecord

  self.table_name = "clinic_monthly_calculations"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :date, class_name: "Operation::Product::Date", foreign_key: "date_id"
  
  # Validations
  validates :date_id, uniqueness: { scope: :clinic_id,
    message: "A mesma comepetência não pode ser usada na mesma PJ." }
  validates :date_id, :clinic_id, presence: true

  #Callbacks  

end