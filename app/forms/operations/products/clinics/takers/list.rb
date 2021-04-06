class Operations::Products::Clinics::Takers::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @taker_params = params.require(:taker).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_taker = can_current_user_list_taker?
    # return false unless @can_current_user_list_taker
    
    @takers = takers
  end

  def takers
    @takers ||= ::Operations::Products::Clinics::TakerRepository.all_active_by_clinic(@taker_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_taker
    cln = ::Operations::Products::Clinics::TakerRepository.list_all(@takers)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_taker
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_taker
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_taker
  end

  def type
    # return "danger" unless @can_current_user_list_taker
  end

  private

  def can_current_user_list_taker?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_takers").can_current_user?
  end
  
end