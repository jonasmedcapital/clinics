module CnpjValidates
  extend ActiveSupport::Concern

  included do
    before_save -> { cnpj_validate }
  end

  def cnpj_validate
    eleven_cnpj = ["00000000000000",
                   "11111111111111",
                   "22222222222222",
                   "33333333333333",
                   "44444444444444",
                   "55555555555555",
                   "66666666666666",
                   "77777777777777",
                   "88888888888888",
                   "99999999999999"]

    if self.cnpj
      if self.cnpj.chars.count != 14
        errors.add(:cnpj, "CNPJ Inválido. ")
      elsif eleven_cnpj.include?(self.cnpj)
        errors.add(:cnpj, "CNPJ Inválido. ")
      else
        cnpj_root = self.cnpj.chars[0 .. 11].map{|i| i.to_i}
        # calculate first digit
        factor = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

        sum = (0..11).inject(0) do |sum, i|
          sum + cnpj_root[i] * factor[i]
        end

        first_validator = sum % 11
        cnpj_root << first_validator = first_validator < 2 ? 0 : 11 - first_validator

        # calculate second digit
        factor.unshift 6

        sum = (0..12).inject(0) do |sum, i|
          sum + cnpj_root[i] * factor[i]
        end

        second_validator = sum % 11
        (cnpj_root << second_validator = second_validator < 2 ? 0 : 11 - second_validator).join


        if cnpj_root.join != self.cnpj
          errors.add(:cnpj, "CNPJ Inválido. ")
        end
      end
    else
      errors.add(:cnpj, "CNPJ Inválido. ")
    end
  end
  
end