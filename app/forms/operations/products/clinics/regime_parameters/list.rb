class Operations::Products::Clinics::RegimeParameters::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @regime_parameter_params = params.require(:regime_parameter).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_list_regime_parameter = can_current_user_list_regime_parameter?
    # return false unless @can_current_user_list_regime_parameter

    @regime_parameters = regime_parameters
  end

  def regime_parameters
    @regime_parameters ||= ::Operations::Products::Clinics::RegimeParameterRepository.all_active_clinic(@regime_parameter_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_regime_parameter
    cln = ::Operations::Products::Clinics::RegimeParameterRepository.list_all(@regime_parameters)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_regime_parameter
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_regime_parameter
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_regime_parameter
  end

  def type
    # return "danger" unless @can_current_user_list_regime_parameter
  end

  private

  def can_current_user_list_regime_parameter?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_regime_parameters").can_current_user?
  end
  
end