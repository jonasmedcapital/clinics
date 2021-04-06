class Users::Accounts::CreateEntityService

  def initialize(attrs)
    
    @attrs = attrs

  end

  def create_account
    account = ::Users::Accounts::EntityRepository.find_by_cpf(@attrs["cpf"])
    
    if account
      account.kind << @attrs["kind"] unless account.kind.include?(@attrs["kind"])
    else
      account = ::Users::Accounts::EntityRepository.build(@attrs["kind"])
      
      account.name = @attrs["name"]
      account.cpf = @attrs["cpf"]
      account.sex = @attrs["sex"]
      account.birthdate = @attrs["birthdate"]
    end
    
    account.save

    if @attrs["email"]
      ::Users::Contacts::CreateAddressService.new(account, attrs)
    end

    if @attrs["ddd"] && @attrs["phone"]
      ::Users::Contacts::CreatePhoneService.new(account, attrs)
    end
    
    
    # ::Users::Accounts::CreateDocumentService.new(account).create_document


    return account
  end
  
  


end