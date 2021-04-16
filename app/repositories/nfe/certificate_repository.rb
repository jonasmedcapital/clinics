class Nfe::CertificateRepository < Base

    def self.build(attrs)
      obj = entity.new
      obj.attributes = attrs
  
      return obj
    end    

    def self.find_and_change(attrs)
      obj = entity.find_by(id: attrs["id"])
      obj.attributes = attrs
  
      return obj
    end
  
    def self.all_active_by_tax_filing(tax_filing_id)
      entity.where(active: true, tax_filing_id: tax_filing_id)
    end

    def self.all_active_by_tax_filing_and_date(tax_filing_id, date_id)
      entity.where(active: true, tax_filing_id: tax_filing_id, date_id: date_id)
    end
  
    def self.list_all(files)
      mapper.map_all(files)
    end
  
    def self.read(file)
      mapper.map(file)
    end
  
    def self.find_by_id(id)
      entity.find_by(id: id)
    end

    def self.find_by_token(token)
      entity.find_by(token: token)
    end
  
    private

    def self.set_token(field)
      token = Base.generate_token
      set_token if valid_field(field, token)
      token
    end
  
    def self.entity
      "Nfe::Certificate".constantize
    end
  
    def self.mapper
      "Nfe::CertificateMapper".constantize
    end
    

  end
    
  