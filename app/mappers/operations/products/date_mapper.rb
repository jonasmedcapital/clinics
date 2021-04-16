class Operations::Products::DateMapper

  def self.map model
    product = model.product
    account = model.product.account

    model_attributes = model.attributes
    if product.name == "medfiling"
      model_attributes = model_attributes.merge({"name" => "#{Operations::Products::EntityRepository::PRODUCT_DATE[product.name]} #{DateDecorator.abbr_with_month_year(model.month, model.year + 1)}"})
    else
      model_attributes = model_attributes.merge({"name" => "#{Operations::Products::EntityRepository::PRODUCT_DATE[product.name]} #{DateDecorator.abbr_with_month_year(model.month, model.year)}"})
    end
    model_attributes = model_attributes.merge({"product_token" => product.uniq_product})
    model_attributes = model_attributes.merge({"account_name" => account.name}) if account
    model_attributes = model_attributes.merge({"date_pretty" => DateDecorator.abbr_with_month_year(model.month, model.year)})
    model_attributes = model_attributes.merge({"month_pretty" => DateDecorator::MONTH_PRETTY[model.month.to_s]})
    model_attributes = model_attributes.merge({"class_name" => model.class.name})
    model_attributes = model_attributes.merge({"defined" => true})
    model_attributes
  end

  def self.map_all model_collection
    model_collection.map{ |model| map(model) }
  end

end