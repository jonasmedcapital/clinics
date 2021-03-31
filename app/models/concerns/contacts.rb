module Contacts
  extend ActiveSupport::Concern

  def _email
    email = self.emails.where(active: true, is_main: true).first
    return email
  end

  def _phone
    phone = self.phones.where(active: true, is_main: true).first
    return phone
  end

  def _address
    address = self.addresses.where(active: true, is_main: true).first
    return address
  end

  def is_main_uniq
    if self.active && self.is_main
      obj_collection = self.class.where(active: true, account_id: self.account.id)
      obj_collection.each do |obj|
        if obj.id != self.id
          errors.add(:is_main, "Já existe um #{self.to_name} principal. ") if obj.is_main
        end
      end
    end
  end
  

end