class Nfe::CompanyRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"] 
    obj.company_id = attrs["company_id"]
    obj.nfe_company_id = attrs["nfe_company_id"] 
    
    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end

  def self.list_all(entities)
    mapper.map_all(entities)
  end

  def self.read(entity)
    mapper.map(entity)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Nfe::Company".constantize
  end

  def self.mapper
    "Nfe::CompanyMapper".constantize
  end

end
