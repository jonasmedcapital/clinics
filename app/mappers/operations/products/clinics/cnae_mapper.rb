class Operations::Products::Clinics::CnaeMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    # obj = obj.merge({"att_pretty" => ::ClassDecorator.att_pretty(model.att)})
    return obj
  end

  def self.map_all_ctiss(cnaes)
    ctiss = Array.new
    cnaes.each do |cnae|
      ::Operations::Products::Cnaes::LIST.each do |ctiss_item|
        if ctiss_item[:cnae_code] == cnae.cnae_code_pretty
          if !ctiss.include?({"cnae_code" => cnae.cnae_code_pretty, "ctiss_code" => ctiss_item[:ctiss_code], "ctiss_desctiption" => ctiss_item[:ctiss_full]})
            ctiss << {"cnae_code" => cnae.cnae_code, "cnae_code_pretty" => cnae.cnae_code_pretty, "ctiss_code" => ctiss_item[:ctiss_code], "ctiss_desctiption" => ctiss_item[:ctiss_full]}
          end
        end
      end
    end
    ctiss
  end

end