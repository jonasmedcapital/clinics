class ContactDecorator < SimpleDelegator  
  
  def phone_pretty
    number = self.number
    ddd = self.ddd
    if number.length == 8
      number = "%s-%s" % [number[0..3], number[4..7]]
    elsif number.length == 9
      number = "%s %s-%s" % [number[0], number[1..4], number[5..8]]
    end
    return "(#{ddd}) #{number}"
  end

  def full_phone_pretty
    phone = self.phone
    prefix = self.prefix
    if phone.length == 8
      phone = "%s-%s" % [phone[0..3], phone[4..7]]
    elsif phone.length == 9
      phone = "%s %s-%s" % [phone[0], phone[1..4], phone[5..8]]
    end
    return "(#{prefix}) #{phone}"
  end

  def number_pretty
    number = self.number
    if number.length == 8
      number = "%s-%s" % [number[0..3], number[4..7]]
    elsif number.length == 9
      number = "%s %s-%s" % [number[0], number[1..4], number[5..8]]
    end
    return "#{number}"
  end

  def postal_code_pretty
    postal_code_numbers = self.postal_code
    return "%s.%s-%s" % [postal_code_numbers[0..1], postal_code_numbers[2..4], postal_code_numbers[5..7]]
  end
  

end