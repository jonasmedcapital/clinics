class Operation::Product::Clinic::Cnae < ApplicationRecord

  self.table_name = "operation_clinic_cnaes"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"

  # Validations

  #Callbacks 

  enum kind: { primary: 0, secondary: 1 }, _prefix: :_
end