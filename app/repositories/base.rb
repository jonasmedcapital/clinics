class RecordNotFoundError < StandardError; end

class Base

  # def self.build(attrs)
  #   attrs = attrs.merge({id: rand(1..200)})
  #   attrs = attrs.merge({active: true})
  #   obj = Lead.new(*attrs.to_h.values_at(*Lead.members))
  #   return obj
  # end

  # def self.find_and_change(attrs)
  #   attrs = attrs.merge({active: true})
  #   obj = Lead.new(*attrs.to_h.values_t(*Lead.members))
  #   return obj
  # end
  
  # Lead = Struct.new(:id, :active, :created_at, :date_id, :name, :council_number, :council_state, :council_type, :intern_source, :source_id, :source_type, :link)

  def self.generate_token
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    size = 16
    token = (0...size).collect { chars[Kernel.rand(chars.length)] }.join
    return token
  end

  def self.download_all(all_data, attributes)
    # CSV.generate(headers: true) do |csv|
    #   csv << attributes
    #   all_data.each do |data|
    #     csv << attributes.map{ |attr| data.send(attr) }
    #   end
    # en

    attributes_translate = attributes.map{|attr| ::Model::Humanize::TRANSLATE[TableDecorator.name(entity.table_name)][attr]}
    csv = []
    csv << attributes_translate
    all_data.each do |data|
      csv << attributes.map{ |attr| data.send(attr) }
    end
    return csv
  end

  def self.download_model(attributes)
    attributes_translate = attributes.map{|attr| ::Model::Humanize::TRANSLATE[TableDecorator.name(entity.table_name)][attr]}
    csv = []
    csv << attributes_translate
    return csv
  end

  def self.valid_token(token)
    obj = entity.new(token: token)
    obj.valid?
    obj.errors.include?("token")
  end

  def self.valid_field(key, value)
    obj = entity.new(key => value)
    obj.valid?
    obj.errors.include?(key)
  end
  

  def all_base
    entity_dataset.where(active: true)
  end
  
  def first
    all_base.first
  end

  def second
    all_base.second
  end
  
  def last
    all_base.last
  end
  
  def find(id)
    all_base.find(id)
  rescue ActiveRecord::RecordNotFound => e
    raise RecordNotFoundError, e
  end

  def find_by_id(id)
    all_base.find_by(id: id)
  end

  def find_by_name(name)
    all_base.where("name LIKE ?", "%#{name}%")
  end
  
  def create(attributes)
    entity.create(attributes)
  end
  
  def update(id:, attributes:)
    find(id).update(**attributes)
  end
  
  def destroy(id)
    find(id).destroy
  end

  def most_recently_created
    all.reorder(created_at: :desc)[0]
  end

  def most_recently_updated
    all.reorder(updated_at: :desc)[0]
  end
  
  private
  
  def entity
    # raise NotImplementedError
    self.class
  end
  
  def entity_dataset
    entity.all
  end
end
