class Users::Accounts::EntityRepository < Base
      
  def self.build(kind)
    token = set_token
    entity.new(kind: [kind], token: token.upcase)
  end

  def self.all_active_by_kind(kind)
    # entity.where(active: true).where("'#{kind}' = ANY (kind)")
    entity.where(active: true).where("? = ANY (kind)", kind)
  end
  
  def self.list_all_with_permissions(collection, current_user, feature)
    mapper.map_all_with_permissions(collection, current_user, feature)
  end

  def self.read_with_permissions(account, current_user, feature)
    mapper.map_with_permissions(account, current_user, feature)
  end

  def self.report_with_permissions(current_user, feature)
    mapper.report_with_permissions(entity, current_user, feature)
  end
  
  def self.read(account)
    mapper.map(account)
  end

  def self.simple_list(accounts)
    mapper.simple_map_all(accounts)
  end
  
  def self.read_user_with_permisssion(account, current_user)
    user = account.user
    if user
      mapper.map_user_with_permisssion(user, current_user)
    else
      user_build = Users::UserRepository.build(account)
      mapper.map_user_with_permisssion(user_build, current_user)
    end
  end

  def self.read_products_with_permisssion(account, current_user)
    mapper.map_products_with_permisssion(account, current_user)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def find_by_email(email)
    all.where(email: email).first
  end

  def self.find_by_cpf(cpf)
    entity.where(cpf: cpf).first
  end

  def self.find_by_cpf_or_initialize_by_cpf_and_kind(cpf, kind)
    obj = entity.find_or_initialize_by(cpf: cpf)
    
    if obj.id?
      new_obj = obj
    else
      new_obj = entity.new(cpf: cpf, kind: [kind])
    end
    
    return new_obj
  end

  def self.get_sales_team
    sales_team = []
    feature_name = "sales_opportunities_entities"
    accounts = self.all_active_by_kind("team").map{|a| a}

    accounts.each do |account|
      if account.user_id
        permission = Users::PermissionRepository.find_by_user_id_and_feature_name(account.user_id, feature_name)
        if permission && permission.can_update
          sales_team << account
        end
      end
    end

    return sales_team
  end

  def self.get_tax_filing_team
    tax_filing_team = []
    feature_name = "medfiling"
    accounts = self.all_active_by_kind("team").map{|a| a}

    accounts.each do |account|
      if account.user_id
        permission = Users::PermissionRepository.find_by_user_id_and_feature_name(account.user_id, feature_name)
        if permission && permission.can_update
          tax_filing_team << account
        end
      end
    end

    return tax_filing_team
  end

  def self.get_booking_team
    booking_team = []
    feature_name = "medbooking"
    accounts = self.all_active_by_kind("team").map{|a| a}

    accounts.each do |account|
      if account.user_id
        permission = Users::PermissionRepository.find_by_user_id_and_feature_name(account.user_id, feature_name)
        if permission && permission.can_update
          booking_team << account
        end
      end
    end

    return booking_team
  end

  def self.get_purchase_team
    purchase_team = []
    feature_name = "financial_purchase_entities"
    accounts = self.all_active_by_kind("team").map{|a| a}

    accounts.each do |account|
      if account.user_id
        permission = Users::PermissionRepository.find_by_user_id_and_feature_name(account.user_id, feature_name)
        if permission && permission.can_update
          purchase_team << account
        end
      end
    end

    return purchase_team
  end

  def self.main_kind(account)
    if account.kind.include?("admin")
      kind = "admin"
    elsif account.kind.include?("team")
      kind = "team"
    elsif account.kind.include?("doctor")
      kind = "doctor"
    elsif account.kind.include?("helper")
      kind = "helper"
    elsif account.kind.include?("patient")
      kind = "patient"
    end
    
    return kind
  end
  
  
  

  def self.find_by_token(token)
    entity.where(token: token).first
  end

  def find_by_name(name)
    all.where("name LIKE ?", "%#{name}%").first
  end

  def list_all(all)
    ::Users::UserMapper.new.map_all_active(all)
  end

  def read(user)
    ::Users::UserMapper.new.map(user)
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

  def self.update_token(account)
    token = set_token
    account.token = token.upcase
    account.save
    user = account.user
    user.token = token.upcase if user
    user.save if user
  end

  def self.update_document(account)
    account.create_document! unless account.document.present?
  end
  

  private

  def self.set_token
    token = ::Base.generate_token
    set_token if valid_token token
    token
  end

  def self.entity
    "User::Account::Entity".constantize
  end

  def self.mapper
    "Users::Accounts::EntityMapper".constantize
  end
  

  ENUM_SEX = {
                "male" => "Masculino",
                "female" => "Feminino",
              }

  ENUM_KIND = {
                "admin" => "IronMan",
                "team" => "Time",
                "doctor" => "Médico",
                "helper" => "Assistente",
                "patient" => "Paciente",
              }
end