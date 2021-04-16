class Operations::Products::Clinics::CnaeRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"]
    obj.cnae_code = attrs["cnae_code"] 
    obj.kind = attrs["kind"] 
    obj.cnae_code_pretty = attrs["cnae_code_pretty"] 
    obj.cnae_description = attrs["cnae_description"] 

    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end
  
  def self.list_all(cnaes)
    mapper.map_all(cnaes)
  end

  def self.list_all_ctiss(cnaes)
    mapper.map_all_ctiss(cnaes)
  end

  def self.read(cnae)
    mapper.map(cnae)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::Cnae".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::CnaeMapper".constantize
  end

end

