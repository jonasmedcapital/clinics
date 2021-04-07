class Operations::Products::Clinics::SocialContractMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({"tax_regime_pretty" => Operations::Products::Clinics::SocialContractRepository::TAX_REGIME[model.tax_regime]})
    return obj
  end

end