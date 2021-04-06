class Operations::Products::DateRepository < Base

  def self.build(attrs)
    entity.new(product_id: attrs["product_id"], month: attrs["month"], year: attrs["year"])
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_product_month_year(obj)
    entity.where(product_id: obj.product.id, month: obj.month, year: obj.year).first
  end
  

  def self.all_active_by_product(product_id)
    entity.where(active: true, product_id: product_id).order(uniq_product_date: :desc)
  end

  def self.list_all(dates)
    mapper.map_all(dates)
  end
  
  def self.read(date)
    mapper.map(date)
  end
  
  

  private

  def self.entity
    "Operation::Product::Date".constantize
  end

  def self.mapper
    "Operations::Products::DateMapper".constantize
  end

end