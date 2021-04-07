class Operations::Products::Clinics::SocialContractRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.clinic_id = attrs["clinic_id"]
    obj.social_capital = attrs["social_capital"]
    obj.shares = attrs["shares"]
    obj.social_object = attrs["social_object"]
    obj.administration_clause = attrs["administration_clause"]
    obj.profit_distribution = attrs["profit_distribution"]
    obj.tax_regime = attrs["tax_regime"]
    obj.special_tax_regime = attrs["special_tax_regime"]
    obj.legal_nature = attrs["legal_nature"]
    obj.registry_number = attrs["registry_number"]
    obj.regional_tax_number = attrs["regional_tax_number"]
    obj.municipal_tax_number = attrs["municipal_tax_number"]

    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end

  def self.list_all(social_contracts)
    mapper.map_all(social_contracts)
  end

  def self.read(social_contract)
    mapper.map(social_contract)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_clinic(id)
    entity.find_by(clinic_id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::SocialContract".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::SocialContractMapper".constantize
  end

  TAX_REGIME = {
    "simple_national" => "Simples Nacional",
    "presumed_profit" => "Lucro Presumido"
  }

end
