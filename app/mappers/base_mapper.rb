class BaseMapper

  def self.map(obj)
    obj
    return obj
  end

  def self.map_attrs(model)
    obj = model.attributes

    return obj
  end
  
  def self.map_all(obj_collection)
    obj_collection.map{ |obj| map(obj) }
  end

  def self.map_all_broadcast(obj_collection)
    obj_collection.map{ |obj| map_broadcast(obj) }
  end
  

end