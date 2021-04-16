class Nfe::Companies::List

  def initialize(params)
    @company_params = params.require(:company).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_company = can_current_user_list_company?
    # return false unless @can_current_user_list_company

    @entities = entities
  end

  def entities
    ::Nfe::CompanyRepository.all_active_clinic(@company_params[:clinic_id])
  end

 def status
    # return :forbidden unless @can_current_user_list_company
    @status
  end

  def process?
    # return false unless @can_current_user_list_company
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_company
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_company
    @message
  end

  def data
    cln = ::Nfe::CompanyRepository.list_all(@entities)

    if cln.empty?
      @status = :ok
      @process = false
      @message = "Não conseguimos carregar os dados"
      @type = "danger"
    else
      @status = :ok
      @process = true
      @message = ""
      @type = "success"
    end
    
    return {:cln => cln.compact}.as_json
  end

  private

  def can_current_user_list_company?
    @can_current_user_list_company ||= ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_invoices").can_current_user?
  end

end