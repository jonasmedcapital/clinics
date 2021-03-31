class CompanyDecorator < SimpleDelegator
  def cnpj_pretty
    cnpj_numbers = cnpj.to_s.rjust(14, "0")
    return "%s.%s.%s/%s-%s" % [cnpj_numbers[0,2], cnpj_numbers[2,3], cnpj_numbers[5,3], cnpj_numbers[8,4], cnpj_numbers[12,2]]
  end

  def self.cnpj_pretty(value)
    cnpj_numbers = value.to_s.rjust(14, "0")
    return "%s.%s.%s/%s-%s" % [cnpj_numbers[0,2], cnpj_numbers[2,3], cnpj_numbers[5,3], cnpj_numbers[8,4], cnpj_numbers[12,2]]
  end
end