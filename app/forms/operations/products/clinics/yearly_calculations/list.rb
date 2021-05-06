class Operations::Products::Clinics::YearlyCalculations::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @calculation_params = params.require(:calculation).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_calculation = can_current_user_list_calculation?
    # return false unless @can_current_user_list_calculation
    
    @calculations = calculations
  end

  def calculations
    @calculations ||= ::Operations::Products::Clinics::YearlyCalculationRepository.all_active_clinic(@calculation_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_calculation
    cln = ::Operations::Products::Clinics::YearlyCalculationRepository.list_all(@calculations)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_calculation
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_calculation
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_calculation
  end

  def type
    # return "danger" unless @can_current_user_list_calculation
  end

  private

  def can_current_user_list_calculation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_calculations").can_current_user?
  end
  
end