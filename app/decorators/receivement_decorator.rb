class ReceivementDecorator < SimpleDelegator  

  def self.code_pretty(code)
    code_numbers = code.to_s.rjust(8, "0")
    return "%s.%s.%s.%s-%s" % [code_numbers[0], code_numbers[1,2], code_numbers[3,2], code_numbers[5,2], code_numbers[7]]
  end

end