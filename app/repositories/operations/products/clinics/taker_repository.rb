class Operations::Products::Clinics::TakerRepository < Base

  def self.build(attrs)
    obj = entity.new     
    obj.clinic_id = attrs["clinic_id"]
    obj.taker_id = attrs["taker_id"]
    obj.taker_type = TAKER_TYPE[attrs["taker_type"]] 
    obj.taker_number = attrs["taker_number"]
    obj.taker_name = attrs["taker_name"]


    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.list_all(takers)
    mapper.map_all(takers)
  end

  def self.read(taker)
    mapper.map(taker)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.all_active_by_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id).order(:created_at)
  end

  def self.find_taker(taker)
    taker_type = taker.taker_type
    taker_id = taker.taker_id
    taker_type.constantize.find(taker_id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::Taker".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::TakerMapper".constantize
  end

  TAKER_TYPE = {
    "account" => "User::Account::Entity",
    "company" => "User::Company::Entity"
  }

  UNTAKER_TYPE = {
    "User::Account::Entity" => "account",
    "User::Company::Entity" => "company"
  }

  TAKER_NFEIO = {
    "User::Account::Entity" => "NaturalPerson",
    "User::Company::Entity" => "LegalEntity"
  }

end