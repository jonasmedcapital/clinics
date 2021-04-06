class CouncilDecorator < SimpleDelegator  

  def self.council_pretty(account)
    council_numbers = account.council_number
    council_state = account.council_state
    if council_numbers.length == 3
      return "#{council_state} %s" % [council_numbers[0..2]]
    elsif council_numbers.length == 4
      return "#{council_state} %s.%s" % [council_numbers[0..0], council_numbers[1..3]]
    elsif council_numbers.length == 5
      return "#{council_state} %s.%s" % [council_numbers[0..1], council_numbers[2..4]]
    elsif council_numbers.length == 6
      return "#{council_state} %s.%s" % [council_numbers[0..2], council_numbers[3..5]]
    elsif council_numbers.length == 7
      return "#{council_state} %s.%s.%s" % [council_numbers[0..0], council_numbers[1..3], council_numbers[4..6]]
    elsif council_numbers.length == 8
      return "#{council_state} %s.%s.%s" % [council_numbers[0..1], council_numbers[2..4], council_numbers[5..7]]
    end
  end

end