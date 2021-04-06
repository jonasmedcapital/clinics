class Operations::Products::Bookings::Dates::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @date_params = params.require(:date).permit(:product_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    @can_current_user_list_date = can_current_user_list_date?

    return false unless @can_current_user_list_date
    @product = product
    
    @dates = dates
  end

  def dates
    @dates ||= ::Operations::Products::DateRepository.all_active_by_product(@date_params[:product_id])
  end

  def product
    @product ||= ::Operations::Products::EntityRepository.find_by_id(@date_params[:product_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    return cln = [] unless @can_current_user_list_date
    cln = ::Operations::Products::DateRepository.list_all(@dates)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    return false unless @can_current_user_list_date
    true
  end

  def status
    return :forbidden unless @can_current_user_list_date
    :ok
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_list_date
  end

  def type
    return "danger" unless @can_current_user_list_date
  end

  private

  def can_current_user_list_date?
    @can_current_user_list_date ||= ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_dates").can_current_user?
  end
  
end