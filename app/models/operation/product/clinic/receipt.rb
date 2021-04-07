class Operation::Product::Clinic::Receipt < ApplicationRecord

    self.table_name = "operation_clinic_receipts"
    
    # Relations
    belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"
    belongs_to :date, class_name: "Operation::Product::Date", foreign_key: "date_id"
  
    # Validations
  
    #Callbacks  

    # Enum
    enum status: { approved: 0, canceled: 1, waiting: 2 }, _prefix: :_

    enum taxation_type: { None: 0, within_city: 1, outside_city: 2, export: 3, free: 4, immune: 5, suspended_court_decision: 6, suspended_administrative_procedure: 7, outside_city_free: 8, outside_city_immune: 9, outside_city_suspended: 10, outside_city_suspended_administrative_procedure: 11 }
  end