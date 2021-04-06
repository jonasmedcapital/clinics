class Operations::Accounts::Products::UpdateService

  def initialize(account, product)
    @product = product
    @account = account
    @account_product = Operations::Accounts::ProductRepository.find_by_account(account.id)
    
    if @product.name == "medfat"
      update_product_receivement
    elsif @product.name == "medreturn"
      update_product_return
    elsif @product.name == "medbooking"
      update_product_booking
    elsif @product.name == "medfiling"
      update_product_filing
    elsif @product.name == "medclinic"
      update_product_clinic
    end
    
  end

  def update_product_return
    @account_product.tax_return_id = @product.id
    @account_product.has_tax_return = true
    @account_product.save
  end

  def update_product_booking
    @account_product.booking_id = @product.id
    @account_product.has_booking = true
    @account_product.save
    ::Operations::Products::TaxReturns::Entities::CreateTaxReturnService.new(@account_product, @account)
  end

  def update_product_receivement
    @account_product.receivement_id = @product.id
    @account_product.has_receivement = true
    @account_product.save
  end

  def update_product_filing
    @account_product.tax_filing_id = @product.id
    @account_product.has_tax_filing = true
    @account_product.save
    ::Operations::Products::TaxReturns::Entities::CreateTaxReturnService.new(@account_product, @account)
  end

  def update_product_clinic
    @account_product.clinic_id = @product.id
    @account_product.has_clinic = true
    @account_product.save
    # ::Operations::Products::TaxReturns::Entities::CreateTaxReturnService.new(@account_product, @account)
  end
  

end