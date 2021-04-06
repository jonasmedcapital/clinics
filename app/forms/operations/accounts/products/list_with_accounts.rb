class Operations::Accounts::Products::ListWithAccounts
  include ActiveModel::Model

  def initialize(params)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    @account_params = params.require(:account).permit(:active)

    @can_current_user_list_product = can_current_user_list_product?
    return false unless @can_current_user_list_product

    @products = products
  end

  def products
    ::Operations::Accounts::ProductRepository.all_active
  end

  def status
    return :forbidden unless @can_current_user_list_product
    :ok
  end

  def type
    return "danger" unless @can_current_user_list_product
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_list_product
  end
  
  def data
    return @cln = [] unless @can_current_user_list_product
    @cln = ::Operations::Accounts::ProductRepository.list_with_account(@products)
    return {:cln => @cln.compact}.as_json
  end
  
  def process?
    return false unless @can_current_user_list_product
    
    if @cln.empty?
      false
    else
      true
    end
    
  end

  private

  def can_current_user_list_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "operation_account_products").can_current_user?
  end
  
end