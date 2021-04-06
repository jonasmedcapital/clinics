class Operations::Products::Entities::Read
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @product_params = params.require(:product).permit(:id, :token, :name, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
    
    @current_user = current_user
    @can_current_user_read_product = can_current_user_read_product?

    return false unless @can_current_user_read_product

    @product = product
  end

  def product
    
    if @product_params[:id].present?
      @product ||= ::Operations::Products::EntityRepository.find_by_id(@product_params[:id])    
    elsif @product_params[:token].present?
      @product ||= ::Operations::Products::EntityRepository.find_by_token(@product_params[:token])    
    end
  
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def process?
    return false unless @can_current_user_read_product
    true
  end

  def status
    return :forbidden unless @can_current_user_read_product
    :ok
  end
  
  def data
    return cln = [] unless @can_current_user_read_product

    if @product_params[:id].present?
      cln = ::Operations::Products::EntityRepository.read(@product)
    elsif @product_params[:token].present?
      cln =  @product
    end
    
    return {:cln => cln.compact}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_product
  end

  def type
    return "danger" unless @can_current_user_read_product
  end

  private

  def can_current_user_read_product?
    @can_current_user_read_product ||= ::UserPolicies.new(@current_user.id, "read", @product_params[:name]).can_current_user?
  end

end