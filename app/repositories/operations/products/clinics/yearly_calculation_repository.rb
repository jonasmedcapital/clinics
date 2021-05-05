class Operations::Products::Clinics::YearlyCalculationRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"]
    obj.date_id = attrs["date_id"] 
    obj.year = attrs["year"] 
    obj.gross_total = attrs["gross_total"]  
    obj.net_receivable = attrs["net_receivable"]
    obj.ir_total_amount = attrs["ir_total_amount"]
    obj.pis_total_amount = attrs["pis_total_amount"]
    obj.cofins_total_amount = attrs["cofins_total_amount"]
    obj.csll_total_amount = attrs["csll_total_amount"]
    obj.inss_total_amount = attrs["inss_total_amount"]
    obj.iss_total_amount = attrs["iss_total_amount"]
    obj.ir_amount_withheld = attrs["ir_amount_withheld"]
    obj.pis_amount_withheld = attrs["pis_amount_withheld"]
    obj.cofins_amount_withheld = attrs["cofins_amount_withheld"]
    obj.csll_amount_withheld = attrs["csll_amount_withheld"]
    obj.inss_amount_withheld = attrs["inss_amount_withheld"]
    obj.iss_amount_withheld = attrs["iss_amount_withheld"]
    obj.ir_amount_due = attrs["ir_amount_due"]
    obj.csll_amount_due = attrs["csll_amount_due"]
    obj.pis_amount_due = attrs["pis_amount_due"]
    obj.cofins_amount_due = attrs["cofins_amount_due"]
    obj.iss_amount_due = attrs["iss_amount_due"]
    obj.inss_amount_due = attrs["inss_amount_due"] 

    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.find_year(clinic_id, year)
    entity.where(clinic_id: clinic_id, year: year)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end

  def self.list_all(partners)
    mapper.map_all(partners)
  end

  def self.read(partner)
    mapper.map(partner)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::YearlyCalculation".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::YearlyCalculationMapper".constantize
  end

end
