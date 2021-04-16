class Nfe::Certificate < ApplicationRecord

  self.table_name = "nfe_certificates"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
  has_one_attached :file

  # Validations

  #Callbacks 

  enum kind: { a1: 0, a2: 1 }, _prefix: :_


end