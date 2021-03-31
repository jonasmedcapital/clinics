class Users::Accounts::Entities::ReadUser
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @account_params = params.require(:account).permit(:id)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

    @can_current_user_read_account = can_current_user_read_account?
    
    return false unless @can_current_user_read_account
    @current_user = current_user
    @account = account
  end

  def account
    @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def process?
    return false unless @can_current_user_read_account
    true
  end

  def status
    return :forbidden unless @can_current_user_read_account
    :ok
  end
  

  def data
    return cln = [] unless @can_current_user_read_account
    user = ::Users::Accounts::EntityRepository.read_user_with_permisssion @account, @current_user
    
    return {:cln => {has_user: @account.user.present?, user: user}}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_account
  end

  def type
    return "danger" unless @can_current_user_read_account
  end

  private

  def can_current_user_read_account?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", @current_user_params[:feature]).can_current_user?
  end

end