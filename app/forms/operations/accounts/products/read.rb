class Operations::Accounts::Products::Read
  include ActiveModel::Model

  def initialize(params)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    @current_user = current_user
    @can_current_user_read_product = can_current_user_read_product?
    return false unless @can_current_user_read_product
    @product = product
    
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def product
    @product ||= ::Operations::Accounts::ProductRepository.find_by_account(@current_user.account.id)
  end

  def status
    return :forbidden unless @can_current_user_read_product
    :ok
  end

  def type
    return "danger" unless @can_current_user_read_product
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_product
  end
  
  def data
    return @cln = [] unless @can_current_user_read_product
    @cln = ::Operations::Accounts::ProductRepository.read(@product)
    return {:cln => @cln.compact}.as_json
  end
  
  def process?
    return false unless @can_current_user_read_product
    
    if @cln.empty?
      false
    else
      true
    end
    
  end

  private

  def can_current_user_read_product?
    @can_current_user_read_product ||= ::UserPolicies.new(@current_user.id, "read", "operation_account_products").can_current_user?
  end
  
end