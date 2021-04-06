class Operations::Products::Clinics::TakerMapper < BaseMapper

  def self.map(model)
    
    obj = model.attributes
    # obj = obj.merge({"att_pretty" => ::ClassDecorator.att_pretty(model.att)})
    obj = obj.merge({"taker_type" => ::Operations::Products::Clinics::TakerRepository::UNTAKER_TYPE[model.taker_type]})
    
    if model.taker_type == "User::Account::Entity"

      account = Operations::Products::Clinics::TakerRepository.find_taker(model)

      account_address = account.addresses.where(kind: "personal", is_main: true).first
      account_email = account.emails.where(kind: "personal", is_main: true).first
      account_phone = account.phones.where(kind: "personal", is_main: true).first
      
      obj = obj.merge({"taker_number_pretty" => AccountDecorator.cpf_pretty(model.taker_number)})
      obj = obj.merge({"taker_account" => account})      
      obj = obj.merge({"taker_address" => account_address})
      obj = obj.merge({"taker_email" => account_email})
      obj = obj.merge({"taker_phone" => account_phone})

    else
      company = Operations::Products::Clinics::TakerRepository.find_taker(model)
      company_address = company.addresses.where(kind: "commercial", is_main: true).first
      company_email = company.emails.where(kind: "commercial", is_main: true).first
      company_phone = company.phones.where(kind: "commercial", is_main: true).first
      
      obj = obj.merge({ "taker_number_pretty" => CompanyDecorator.cnpj_pretty(model.taker_number)})
      obj = obj.merge({ "taker_company" => company})
      obj = obj.merge({ "taker_address" => company_address})
      obj = obj.merge({ "taker_email" => company_email})
      obj = obj.merge({ "taker_phone" => company_phone})
    end

    return obj
  end



end