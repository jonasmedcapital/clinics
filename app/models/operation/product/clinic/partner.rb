class Operation::Product::Clinic::Partner < ApplicationRecord

  self.table_name = "operation_clinic_partners"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id"
  
  # Validations

  #Callbacks  
end