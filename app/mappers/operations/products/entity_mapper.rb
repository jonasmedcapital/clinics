class Operations::Products::EntityMapper < BaseMapper

  def self.map model
    account = model.account

    obj = model.attributes
    obj = obj.merge({ "token" => model.uniq_product })
    obj = obj.merge({ "account_name" => account.name })
    obj = obj.merge({ "account_token" => account.token })
    obj = obj.merge({ "account_path" => "/a/minha-conta/#{account.token}" })
    obj = obj.merge({ "account_cpf" => account.cpf })
    obj = obj.merge({ "account_cpf_pretty" => account.cpf_pretty })
    obj = obj.merge({ "account_sex" => account.sex })
    obj = obj.merge({ "account_sex_pretty" => ::Users::Accounts::EntityRepository::ENUM_SEX[account.sex] })

    if account.birthdate  
      obj = obj.merge({ "account_birthdate_pretty" => DateDecorator.abbr_month_date(account.birthdate) })
    end

    if account.user_id
      obj = obj.merge({ "user" => true })
    else
      obj = obj.merge({ "user" => false })
    end

    obj = obj.merge({ "kind_pretty" => ::Operations::Products::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "status_pretty" => ::Operations::Products::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "product_name" => ::Operations::Products::EntityRepository::ENUM_NAME[model.name] })
    obj = obj.merge({ "product_path" => "/a/#{::Operations::Products::EntityRepository::PRODUCT_PATH[model.name][model.kind]}/#{model.uniq_product}" })
    obj = obj.merge({ "started_at_pick_date" => DateDecorator.abbr_month_date(model.started_at) })
    if model.name == "medfiling"
      obj = obj.merge({ "calculations" => Operations::Products::TaxFilings::CalculationRepository.list(model.tax_filing_calculations) })
    # elsif 
      # obj = obj.merge({ "calculations" => model.booking_calculations })
    # else
      # obj = obj.merge({ "calculations" => [] })
    end

    return obj
  end

  def self.map_report entity, name
    data = {}

    # usar humanize product or product entity repository

    #data = data.merge({"product_kind" => entity.where(active: true).where("? = ANY (name)", name).count})
    data = data.merge({"product_total" => entity.where(active: true).where(name: name).count})
    data = data.merge({"product_kind" => Operations::Products::EntityRepository::ENUM_NAME[name]})
    data = data.merge({"product_url" => Operations::Products::EntityRepository::CONFIG_PATH[name]})
  end

  def self.map_collection model_collection
    model_collection.map{ |model| map(model) }
  end
  
  def map_all_active model_collection
    model_collection.where(active: true).map{ |model| map(model) }
  end

  def self.map_all_with_permissions model_collection, product_name, current_user
    collection = model_collection.map{ |model| map(model) }
    permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, product_name)}
    {:collection => collection, :permissions => permissions}
  end

  def self.map_with_permissions model, product_name, current_user
    collection = map model
    permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, product_name)}
    {:collection => collection, :permissions => permissions}
  end

  def self.report_with_permissions entity, current_user, feature
    collection = map_report(entity, feature)
    permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
    {:collection => collection, :permissions => permissions}
  end

end