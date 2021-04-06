class Operations::Products::Clinics::Partners::List
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @partner_params = params.require(:partner).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_partner = can_current_user_list_partner?
    # return false unless @can_current_user_list_partner
    
    @partners = partners
  end

  def partners
    @partners ||= ::Operations::Products::Clinics::PartnerRepository.all_active_clinic(@partner_params[:clinic_id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_list_partner
    cln = ::Operations::Products::Clinics::PartnerRepository.list_all(@partners)
    return {:cln => cln.compact}.as_json
  end
  
  def process?
    # return false unless @can_current_user_list_partner
    true
  end

  def status
    # return :forbidden unless @can_current_user_list_partner
    :ok
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_partner
  end

  def type
    # return "danger" unless @can_current_user_list_partner
  end

  private

  def can_current_user_list_partner?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_partners").can_current_user?
  end
  
end