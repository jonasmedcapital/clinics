class Operations::Products::Clinics::SocialContracts::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @social_contract_params = params.require(:social_contract).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_list_social_contract = can_current_user_list_social_contract?
    # return false unless @can_current_user_list_social_contract

    @social_contracts = social_contracts
  end

  def social_contracts
    @social_contracts ||= ::Operations::Products::Clinics::SocialContractRepository.all_active_clinic(@social_contract_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_social_contract
    cln = ::Operations::Products::Clinics::SocialContractRepository.list_all(@social_contracts)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_social_contract
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_social_contract
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_social_contract
  end

  def type
    # return "danger" unless @can_current_user_list_social_contract
  end

  private

  def can_current_user_list_social_contract?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_social_contracts").can_current_user?
  end
  
end