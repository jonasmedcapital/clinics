class Operations::Accounts::ProductMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "tax_filing_token" => model.tax_filing.uniq_product }) if model.has_tax_filing
    obj = obj.merge({ "tax_return_token" => model.tax_return.uniq_product }) if model.has_tax_return
    obj = obj.merge({ "booking_token" => model.booking.uniq_product }) if model.has_booking
    obj = obj.merge({ "legal_token" => model.booking.uniq_product }) if model.has_legal
    obj = obj.merge({ "receivement_token" => model.receivement.uniq_product }) if model.has_receivement
    obj = obj.merge({ "billing_token" => model.billing.uniq_product }) if model.has_billing

    return obj
  end

  def self.map_with_account(model)
    obj = model.attributes
    account = model.account

    obj = obj.merge({ "account_name" => account.name })
    obj = obj.merge({ "account_cpf" => account.cpf })
    obj = obj.merge({ "account_cpf_pretty" => ::AccountDecorator.new(account).cpf_pretty })
    obj = obj.merge({ "account_slug" => account.slug })
    obj = obj.merge({ "tax_filing_token" => model.tax_filing.uniq_product }) if model.has_tax_filing
    obj = obj.merge({ "tax_return_token" => model.tax_return.uniq_product }) if model.has_tax_return
    obj = obj.merge({ "booking_token" => model.booking.uniq_product }) if model.has_booking
    obj = obj.merge({ "legal_token" => model.booking.uniq_product }) if model.has_legal
    obj = obj.merge({ "receivement_token" => model.receivement.uniq_product }) if model.has_receivement
    obj = obj.merge({ "billing_token" => model.billing.uniq_product }) if model.has_billing

    return obj
  end
  


  def self.map_with_accounts(obj_collection)
    obj_collection.map{ |obj| map_with_account(obj) }
  end
  
  
end