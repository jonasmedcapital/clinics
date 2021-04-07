class Operations::Products::Clinics::ReceiptRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"]
    obj.date_id = attrs["date_id"]
    obj.bank_id = attrs["bank_id"]
    obj.taker_id = attrs["taker_id"]
    obj.taker_type = TAKER_TYPE[attrs["taker_type"]]
    obj.taker_name = attrs["taker_name"]
    obj.taker_federal_tax_number = attrs["taker_federal_tax_number"]
    obj.taker_municipal_tax_number = attrs["taker_municipal_tax_number"]
    obj.taker_email = attrs["taker_email"]
    obj.taker_country = attrs["taker_country"]
    obj.taker_postal_code = attrs["taker_postal_code"]
    obj.taker_street = attrs["taker_street"]
    obj.taker_number = attrs["taker_number"]
    obj.taker_complement = attrs["taker_complement"]
    obj.taker_district = attrs["taker_district"]
    obj.taker_city_code = attrs["taker_city_code"]
    obj.taker_city_name = attrs["taker_city_name"]
    obj.taker_state = attrs["taker_state"]
    obj.city_service_code = attrs["city_service_code"]
    obj.federal_service_code = attrs["federal_service_code"]
    obj.cnae_code = attrs["cnae_code"]
    obj.description = attrs["description"]
    obj.services_amount = attrs["services_amount"]
    obj.rps_serial_number = attrs["rps_serial_number"]
    obj.issued_on = attrs["issued_on"].to_time
    obj.rps_number = attrs["rps_number"]
    obj.taxation_type = attrs["taxation_type"]
    obj.iss_rate = attrs["iss_rate"]
    obj.iss_tax_amount = attrs["iss_tax_amount"]
    obj.deductions_amount = attrs["deductions_amount"]
    obj.unconditioned_amount = attrs["unconditioned_amount"]
    obj.conditioned_amount = attrs["conditioned_amount"]
    obj.others_amount_withheld = attrs["others_amount_withheld"]
    obj.source = attrs["source"]
    obj.version = attrs["version"]
    obj.total_rate = attrs["total_rate"]
    obj.additional_information = attrs["additional_information"]
    obj.service_state = attrs["service_state"]
    obj.service_city_code = attrs["service_city_code"]
    obj.service_city_name = attrs["service_city_name"]
    obj.ir_amount_withheld = attrs["ir_amount_withheld"]
    obj.pis_amount_withheld = attrs["pis_amount_withheld"]
    obj.cofins_amount_withheld = attrs["cofins_amount_withheld"]
    obj.csll_amount_withheld = attrs["csll_amount_withheld"]
    obj.inss_amount_withheld = attrs["inss_amount_withheld"]
    obj.iss_amount_withheld = attrs["iss_amount_withheld"]
    obj.ir_total_amount = attrs["ir_total_amount"]
    obj.pis_total_amount = attrs["pis_total_amount"]
    obj.cofins_total_amount = attrs["cofins_total_amount"]
    obj.csll_total_amount = attrs["csll_total_amount"]
    obj.inss_total_amount = attrs["inss_total_amount"]
    obj.iss_total_amount = attrs["iss_total_amount"]
    obj.ir_amount_due = attrs["ir_amount_due"]
    obj.csll_amount_due = attrs["csll_amount_due"]
    obj.pis_amount_due = attrs["pis_amount_due"]
    obj.cofins_amount_due = attrs["cofins_amount_due"]
    obj.iss_amount_due = attrs["iss_amount_due"]
    obj.inss_amount_due = attrs["inss_amount_due"]
    obj.nominal_aliquot = attrs["nominal_aliquot"]
    obj.ir_aliquot = attrs["ir_aliquot"]
    obj.csll_aliquot = attrs["csll_aliquot"]
    obj.pis_aliquot = attrs["pis_aliquot"]
    obj.cofins_aliquot = attrs["cofins_aliquot"]
    obj.inss_aliquot = attrs["inss_aliquot"]
    obj.iss_aliquot = attrs["iss_aliquot"]
    obj.effective_aliquot = attrs["effective_aliquot"]
    obj.ir_effective_aliquot = attrs["ir_effective_aliquot"]
    obj.csll_effective_aliquot = attrs["csll_effective_aliquot"]
    obj.pis_effective_aliquot = attrs["pis_effective_aliquot"]
    obj.cofins_effective_aliquot = attrs["cofins_effective_aliquot"]
    obj.inss_effective_aliquot = attrs["inss_effective_aliquot"]
    obj.iss_effective_aliquot = attrs["iss_effective_aliquot"]
    obj.total_due = attrs["total_due"]
    obj.total_withheld = attrs["total_withheld"]
    obj.total_withheld_parcial = attrs["total_withheld_parcial"]
    obj.net_receivable = attrs["net_receivable"]
    obj.status = attrs["status"]
    obj.tax_regime = attrs["tax_regime"]
    obj.value_per_partner = attrs["value_per_partner"]
    obj.default_withheld = attrs["default_withheld"]
    obj.iss_aliquot_check = attrs["iss_aliquot_check"]
    obj.payment_installments = attrs["payment_installments"]
    
    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end
  
  def self.list_all(rules)
    mapper.map_all(rules)
  end

  def self.read(rule)
    mapper.map(rule)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::Receipt".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::ReceiptMapper".constantize
  end

  TAKER_TYPE = {
    "account" => "User::Account::Entity",
    "company" => "User::Company::Entity"
  }

  UNTAKER_TYPE = {
    "User::Account::Entity" => "account",
    "User::Company::Entity" => "company"
  }

end
