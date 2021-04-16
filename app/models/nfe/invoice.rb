class Nfe::Invoice < ApplicationRecord

  self.table_name = "nfe_invoice_entities"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id"
  belongs_to :receipt, class_name: "Operation::Product::Clinic::Receipt", foreign_key: "receipt_id"

  has_one_attached :pdf
  has_one_attached :xml

  # Validations

  #Callbacks 

  enum status: { error: 0, none: 1, created: 2, issued: 3, cancelled: 4 }, _prefix: :_
  
end
