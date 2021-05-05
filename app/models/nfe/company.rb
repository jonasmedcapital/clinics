class Nfe::Company < ApplicationRecord

  self.table_name = "nfe_company_entities"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  belongs_to :company, class_name: "User::Company::Entity", foreign_key: "company_id"

  # Validations
  validates :company_id, presence: {message: "Empresa não pode ficar em branco. "}, uniqueness: { message: "Empresa já existe na base. "  }
  validates :nfe_company_id, presence: {message: "Empresa não pode ficar em branco. "}, uniqueness: { message: "Empresa já existe na base. "  }
  validates :clinic_id, presence: {message: "Token não pode ficar em branco. "}, uniqueness: { message: "Produto já existe na base. "  }

  #Callbacks 

end