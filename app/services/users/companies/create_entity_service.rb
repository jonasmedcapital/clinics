class Users::Companies::CreateEntityService

  def initialize(attrs)
    
    @attrs = attrs

  end

  def create_company

    company = ::Users::Companies::EntityRepository.build(@attrs)

    company.name = @attrs["name"]
    company.trade_name = @attrs["name"]
    company.cnpj = @attrs["cnpj"]
    company.kind << @attrs["kind"]
    company.subkind << @attrs["subkind"]

    company.save

    return company
  end
  
  


end