class Operations::Accounts::ProductRepository

  def self.find_by_account(account_id)
    obj = entity.where(active: true, account_id: account_id).first_or_initialize

    if obj.id?
      return obj
    else
      return entity.new(account_id: account_id)
    end
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.read(product)
    mapper.map(product)
  end

  def self.list_with_account(products)
    mapper.map_with_accounts(products)
  end

  # def self.clean_tax_filing(obj)
  #   obj.tax_filing_id = nil
  #   obj.has_tax_filing = false
  #   obj.save
  # end
  
  # obj = Operation::Account::Product.first
  # Operations::Accounts::ProductRepository.clean_tax_filing(obj)

  private

  def self.entity
    "Operation::Account::Product".constantize
  end

  def self.mapper
    "Operations::Accounts::ProductMapper".constantize
  end
  

end