class Nfe::Company < ApplicationRecord

  self.table_name = "nfe_company_entities"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id"

  # Validations

  #Callbacks 

end