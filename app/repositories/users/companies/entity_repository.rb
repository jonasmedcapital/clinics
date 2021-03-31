class Users::Companies::EntityRepository < Base
  
  def self.build(kind)
    entity.new(kind: [kind])
  end

  def self.all_active_by_kind(kind)
    entity.where(active: true).where("? = ANY (kind)", kind)
  end

  def self.all_active_by_subkind(subkind)
    entity.where(active: true).where("? = ANY (subkind)", subkind)
  end
  
  def self.list_all_with_permissions(collection, current_user, feature)
    mapper.map_all_with_permissions(collection, current_user, feature)
  end

  def self.read_with_permissions(company, current_user, feature)
    mapper.map_with_permissions(company, current_user, feature)
  end

  def self.report_with_permissions(current_user, feature)
    mapper.report_with_permissions(entity, current_user, feature)
  end
  
  def self.read(company)
    mapper.map(company)
  end
  
  def self.read_user_with_permisssion(company, current_user)
    user = company.user
    if user
      mapper.map_user_with_permisssion(user, current_user)
    else
      user_build = Users::UserRepository.build(company)
      mapper.map_user_with_permisssion(user_build, current_user)
    end
  end

  def self.read_products_with_permisssion(company, current_user)
    mapper.map_products_with_permisssion(company, current_user)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_cnpj(cnpj)
    entity.find_by(cnpj: cnpj)
  end

  def self.find_by_cnpj_or_initialize_by_cnpj_and_kind(cnpj, kind)
    obj = entity.find_or_initialize_by(cnpj: cnpj)
    
    if obj.id?
      new_obj = obj
    else
      new_obj = entity.new(cnpj: cnpj, kind: [kind], subkind: ["provider"])
    end
    
    return new_obj
  end

  def self.find_by_name(name)
    # all.where("name LIKE ?", "%#{name}%").first
    # all.where(["unaccent(lower(name)) LIKE :search", search: "%#{name}%"]).first
    entity.where(active: true).where(name: name).first
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

  private

  def self.entity
    "User::Company::Entity".constantize
  end

  def self.mapper
    "Users::Companies::EntityMapper".constantize
  end
  
  ENUM_SUBKIND = {
                    "none" => "Nenhum",
                    "operator" => "Operadora de Saúde",
                    "provider" => "Provedor de Serviços"
                  }

end