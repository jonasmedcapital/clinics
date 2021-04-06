class CurrencyDecorator < SimpleDelegator

  def self.currency_pretty(value)

    dec = ((value.to_d - value.to_i) * 100).to_i.to_s.rjust(2, "0")
    int = value.to_i.to_s

    if int.length <= 3
      return "R$ %s,%s" % [int, dec]
    elsif int.length == 4
      return "R$ %s.%s,%s" % [int[0,1], int[1,3], dec]
    elsif int.length == 5
      return "R$ %s.%s,%s" % [int[0,2], int[2,3], dec]
    elsif int.length == 6
      return "R$ %s.%s,%s" % [int[0,3], int[3,3], dec]
    elsif int.length == 7
      return "R$ %s.%s.%s,%s" % [int[0,1], int[1,3], int[4,3], dec]
    elsif int.length == 8
      return "R$ %s.%s.%s,%s" % [int[0,2], int[2,3], int[5,3], dec]
    elsif int.length == 9
      return "R$ %s.%s.%s,%s" % [int[0,3], int[3,3], int[6,3], dec]
    elsif int.length == 10
      return "R$ %s.%s.%s.%s,%s" % [int[0,1], int[1,3], int[4,3], int[7,3], dec]
    elsif int.length == 11
      return "R$ %s.%s.%s.%s,%s" % [int[0,2], int[2,3], int[5,3], int[8,3], dec]
    elsif int.length == 12
      return "R$ %s.%s.%s.%s,%s" % [int[0,3], int[3,3], int[6,3], int[9,3], dec]
    else
      return value
    end

    # int_numbers = cnpj.to_s.rjust(14, "0")
    # return "%s.%s.%s/%s-%s" % [cnpj_numbers[0,2], cnpj_numbers[2,3], cnpj_numbers[5,3], cnpj_numbers[8,4], cnpj_numbers[12,2]]

  end

  def self.money_brl_pretty(value)

    dec = ((value.to_d - value.to_i) * 100).to_i.to_s.rjust(2, "0")
    int = value.to_i.to_s

    if int.length <= 3
      return "%s,%s" % [int, dec]
    elsif int.length == 4
      return "%s.%s,%s" % [int[0,1], int[1,3], dec]
    elsif int.length == 5
      return "%s.%s,%s" % [int[0,2], int[2,3], dec]
    elsif int.length == 6
      return "%s.%s,%s" % [int[0,3], int[3,3], dec]
    elsif int.length == 7
      return "%s.%s.%s,%s" % [int[0,1], int[1,3], int[4,3], dec]
    elsif int.length == 8
      return "%s.%s.%s,%s" % [int[0,2], int[2,3], int[5,3], dec]
    elsif int.length == 9
      return "%s.%s.%s,%s" % [int[0,3], int[3,3], int[6,3], dec]
    elsif int.length == 10
      return "%s.%s.%s.%s,%s" % [int[0,1], int[1,3], int[4,3], int[7,3], dec]
    elsif int.length == 11
      return "%s.%s.%s.%s,%s" % [int[0,2], int[2,3], int[5,3], int[8,3], dec]
    elsif int.length == 12
      return "%s.%s.%s.%s,%s" % [int[0,3], int[3,3], int[6,3], int[9,3], dec]
    else
      return value
    end

    # int_numbers = cnpj.to_s.rjust(14, "0")
    # return "%s.%s.%s/%s-%s" % [cnpj_numbers[0,2], cnpj_numbers[2,3], cnpj_numbers[5,3], cnpj_numbers[8,4], cnpj_numbers[12,2]]

  end

end