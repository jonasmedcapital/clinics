class Operations::Products::Clinics::RegimeParameterMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    # obj = obj.merge({"att_pretty" => ::ClassDecorator.att_pretty(model.att)})
    return obj
  end

end