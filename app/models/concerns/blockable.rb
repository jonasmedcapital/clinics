module Blockable
  extend ActiveSupport::Concern

  

  def blocked_user

    if user_blocked?
      errors.add(:cpf, "CPF Bloqueado. ")
    end
    
  end
  

  def user_blocked?
    user = User.where(cpf: self.cpf).first
    if user
      return true if user.blocked
    end
    return false
  end
  

end