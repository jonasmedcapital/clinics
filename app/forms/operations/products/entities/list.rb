class Operations::Products::Entities::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @mode_params = params.require(:mode).permit(:mode)
    @account_params = params.require(:account).permit(:account_id)
    @product_params = params.require(:product).permit(:name, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)

    @can_current_user_list_product = can_current_user_list_product?
    return false unless @can_current_user_list_product

    @current_user = current_user
    @account = account
    @products = products
  end

  def products
    
    if @mode_params[:mode] == "account"
      @products ||= ::Operations::Products::EntityRepository.all_active_by_account_and_name(@account_params[:account_id], @product_params[:name])
    elsif @mode_params[:mode] == "product"
      @products ||= ::Operations::Products::EntityRepository.all_active_by_name_and_kind(@product_params[:name], @product_params[:kind])
    end
    
  end

  def account
    @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def process?
    return false unless @can_current_user_list_product
    true
  end

  def status
    return :forbidden unless @can_current_user_list_product
    :ok
  end
  
  def data
    return cln = [] unless @can_current_user_list_product

    if @product_params[:name] == "medfat" || @mode_params[:mode] == "account"
      cln = ::Operations::Products::EntityRepository.list_with_permissions @products, @product_params[:name], @current_user
    else
      cln = ::Operations::Products::EntityRepository.list_all @products
    end

    return {:cln => cln.compact}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_list_product
  end

  def type
    return "danger" unless @can_current_user_list_product
  end

  private

  def can_current_user_list_product?
    @can_current_user_list_product ||= ::UserPolicies.new(@current_user_params[:current_user_id], "list", @product_params[:name]).can_current_user?
  end
  


end