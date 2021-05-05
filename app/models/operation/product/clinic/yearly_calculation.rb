class Operation::Product::Clinic::YearlyCalculation < ApplicationRecord

  self.table_name = "clinic_yealrly_calculations"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :date, class_name: "Operation::Product::Date", foreign_key: "date_id"
  
  # Validations
  validates :year, uniqueness: { scope: :clinic_id,
    message: "O mesmo ano não pode ser usado duas vezes." }
  validates :date_id, :clinic_id, presence: true

  #Callbacks  

end