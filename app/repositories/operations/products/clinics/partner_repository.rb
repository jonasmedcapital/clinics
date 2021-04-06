class Operations::Products::Clinics::PartnerRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"]
    obj.account_id = attrs["account_id"] 
    obj.name = attrs["name"] 
    obj.cpf = attrs["cpf"] 
    obj.financial = attrs["financial"] 
    obj.operational = attrs["operational"] 
    obj.admnistrative = attrs["admnistrative"] 
    obj.doctor = attrs["doctor"] 
    obj.legal = attrs["legal"] 
    obj.technical = attrs["technical"] 
    obj.shares = attrs["shares"] 
    obj.entried_at = attrs["entried_at"] 
    obj.exited_at = attrs["exited_at"] 
    obj.exited_description = attrs["exited_description"] 

    return obj
  end

  def self.all_active
    entity.where(active: true)
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
    "Operation::Product::Clinic::Partner".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::PartnerMapper".constantize
  end

end
