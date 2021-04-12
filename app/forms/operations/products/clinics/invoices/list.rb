class Operations::Products::Clinics::Invoices::Entities::List

  def initialize(params)
    @entity_params = params.require(:entity).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_entity = can_current_user_list_entity?
    # return false unless @can_current_user_list_entity

    @entities = entities
  end

  def entities
    ::Operations::Products::Clinics::Invoices::EntityRepository.all_active_clinic(@entity_params[:clinic_id])
  end

 def status
    # return :forbidden unless @can_current_user_list_entity
    @status
  end

  def process?
    # return false unless @can_current_user_list_entity
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_entity
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_entity
    @message
  end

  def data
    cln = ::Operations::Products::Clinics::Invoices::EntityRepository.list_all(@entities)

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

  def can_current_user_list_entity?
    @can_current_user_list_entity ||= ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_invoices").can_current_user?
  end

end