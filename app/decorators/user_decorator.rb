class UserDecorator < SimpleDelegator  
  def cpf_pretty
    cpf_numbers = self.cpf
    return "%s.%s.%s-%s" % [cpf_numbers[0..2], cpf_numbers[3..5], cpf_numbers[6..8], cpf_numbers[9..10]]
  end
end