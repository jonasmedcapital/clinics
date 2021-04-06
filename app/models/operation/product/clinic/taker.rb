class Operation::Product::Clinic::Taker < ApplicationRecord

  self.table_name = "operation_clinic_takers"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company", optional: true

  # Validations

  #Callbacks  
end