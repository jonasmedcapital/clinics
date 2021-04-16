class Nfe::InvoiceRepository < Base

  def self.build(attrs)
    obj = entity.new    
    obj.clinic_id = attrs["clinic_id"] 
    obj.company_id = attrs["company_id"]
    obj.receipt_id = attrs["receipt_id"] 
    obj.nfe_invoice_id = attrs["nfe_invoice_id"] 
    obj.status = attrs["status"] 
    
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
    "Nfe::Invoice".constantize
  end

  def self.mapper
    "Nfe::InvoiceMapper".constantize
  end

  STATUS = {
    "error" => "Error",
    "none" => "None",
    "created" => "Created",
    "issued" => "Issued",
    "cancelled" => "Cancelled"
  }

  STATUS_PRETTY = {
    "error" => "Erro",
    "none" => "Sem status",
    "created" => "criada",
    "issued" => "Emitida",
    "cancelled" => "Cancelada"
  }

end
