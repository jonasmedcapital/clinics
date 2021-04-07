class Operations::Products::Clinics::Cnaes::ListCtiss
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @cnae_params = params.require(:cnae).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_cnae = can_current_user_list_cnae?
    # return false unless @can_current_user_list_cnae
    
    @cnaes = cnaes
  end

  def cnaes
    @cnaes ||= ::Operations::Products::Clinics::CnaeRepository.all_active_clinic(@cnae_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_cnae
    cln = ::Operations::Products::Clinics::CnaeRepository.list_all_ctiss(@cnaes)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_cnae
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_cnae
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_cnae
  end

  def type
    # return "danger" unless @can_current_user_list_cnae
  end

  private

  def can_current_user_list_cnae?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_cnaes").can_current_user?
  end
  
end