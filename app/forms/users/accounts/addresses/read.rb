class Users::Accounts::Addresses::Read
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @account_params = params.require(:account).permit(:account_id)
    @address_params = params.require(:address).permit(:address_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
    
    return false unless can_current_user_read_address?
    @current_user = current_user
    @account = account
    @address = address
  end

  def account
    @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
  end

  def address
    @address ||= ::Users::Accounts::AddressRepository.find_by_id(@address_params[:address_id])
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def process?
    return false unless can_current_user_read_address?
    true
  end

  def status
    return :forbidden unless can_current_user_read_address?
    :ok
  end
  

  def data
    return cln = [] unless can_current_user_read_address?
    if @current_user_params[:permissions]
      cln = ::Users::Accounts::AddressRepository.read_with_permissions @address, @current_user
    else
      cln = ::Users::Accounts::AddressRepository.read @address
    end
    
    return {:cln => cln.compact}.as_json
  end

  def message
    return message = "A ação não é permitida" unless can_current_user_read_address?
  end

  def type
    return "danger" unless can_current_user_read_address?
  end

  private

  def can_current_user_read_address?
    @can_current_user_read_address ||= ::UserPolicies.new(current_user.id, "read", "addresses").can_current_user?
  end
  


end