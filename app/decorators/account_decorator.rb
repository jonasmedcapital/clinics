class AccountDecorator < SimpleDelegator  
  def cpf_pretty
    cpf_numbers = self.cpf
    return "%s.%s.%s-%s" % [cpf_numbers[0..2], cpf_numbers[3..5], cpf_numbers[6..8], cpf_numbers[9..10]]
  end

  def self.cpf_pretty(value)
    cpf_numbers = value
    return "%s.%s.%s-%s" % [cpf_numbers[0..2], cpf_numbers[3..5], cpf_numbers[6..8], cpf_numbers[9..10]]
  end

  def crm_pretty
    crm_numbers = self.crm
    crm_state = self.crm_state
    if crm_numbers.length == 3
      return "#{crm_state} %s" % [crm_numbers[0..2]]
    elsif crm_numbers.length == 4
      return "#{crm_state} %s.%s" % [crm_numbers[0..0], crm_numbers[1..3]]
    elsif crm_numbers.length == 5
      return "#{crm_state} %s.%s" % [crm_numbers[0..1], crm_numbers[2..4]]
    elsif crm_numbers.length == 6
      return "#{crm_state} %s.%s" % [crm_numbers[0..2], crm_numbers[3..5]]
    elsif crm_numbers.length == 7
      return "#{crm_state} %s.%s.%s" % [crm_numbers[0..0], crm_numbers[1..3], crm_numbers[4..6]]
    elsif crm_numbers.length == 8
      return "#{crm_state} %s.%s.%s" % [crm_numbers[0..1], crm_numbers[2..4], crm_numbers[5..7]]
    end
  end
end