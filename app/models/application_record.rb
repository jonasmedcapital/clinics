class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def inactive_associations
    inactive_associations = true unless self.active

    if inactive_associations
      ActiveRecord::Base.transaction do
        obj = self
        obj_class = self.class
        has_many_associations = obj_class.reflect_on_all_associations(:has_many).map{|assoc| assoc.name}

        has_many_associations.each do |association|
          obj.send(association).each do |obj_dependent|
            obj_dependent.active = false
            obj_dependent.save
          end
        end
        
      end
    end

  end


  def generate_token
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    size = 16
    token = (0...size).collect { chars[Kernel.rand(chars.length)] }.join
    return token
  end
  
end
