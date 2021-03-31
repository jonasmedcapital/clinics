class Users::Accounts::AddressRepository < Base
      
  def self.build(record_id, record_type)
    if record_type == "account_entities"
      obj = entity.new(account_id: record_id, record_type: record_type)
    elsif record_type == "company_entities"
      obj = entity.new(company_id: record_id, record_type: record_type)
    end

    return obj
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_address(address)
    entity.where(address: address).first
  end

  def self.find_by_any_address(address)
    entity.where("address LIKE ?", "%#{address}%").first
  end

  def self.all_active_by_account(account_id)
    account = ::Users::Accounts::EntityRepository.find_by_id(account_id)
    addresses = account.addresses.where(active: true)
  end

  def self.active_addresses(account)
    addresses = []
    account.addresses.where(active: true).each do |address|
      addresses << read(address)
    end

    return addresses
  end
  
  def self.list_all_with_permissions(addresses, current_user)
    mapper.map_all_with_permissions(addresses, current_user)
  end

  def self.list_all(addresses)
    mapper.map_all_active(addresses)
  end

  def self.read(address)
    mapper.map(address)
  end

  def self.read_with_permissions(address, current_user)
    mapper.map_with_permissions(address, current_user)
  end 

  def count
    all.count
  end

  def first
    all.first
  end

  def second
    all.second
  end
  
  def last
    all.last
  end

  private

  def self.entity
    "User::Contact::Address".constantize
  end

  def self.mapper
    "Users::Accounts::AddressMapper".constantize
  end

  ENUM_KIND = {
                "personal" => "Pessoal",
                "commercial" => "Comercial"
              }
  

end