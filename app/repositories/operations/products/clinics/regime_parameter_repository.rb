class Operations::Products::Clinics::RegimeParameterRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.clinic_id = attrs["clinic_id"]
    obj.monthly = attrs["monthly"]
    obj.per_partner = attrs["per_partner"]
    obj.tax_regime = attrs["tax_regime"]
    obj.special_tax_regime = attrs["special_tax_regime"]
    obj.legal_nature = attrs["legal_nature"]
    obj.year = attrs["year"]
    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end

  def self.list_all(parameters)
    mapper.map_all(parameters)
  end

  def self.read(parameter)
    mapper.map(parameter)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::RegimeParameter".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::RegimeParameterMapper".constantize
  end

end
