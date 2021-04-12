class Operations::Products::Clinics::Invoices::Create

  attr_accessor :status, :type, :message

  def initialize(params)
    @entity_params = params.require(:entity).permit(:clinic_id, :company_id, :receipt_id )
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_create_entity = can_current_user_create_entity?
    # return false unless @can_current_user_create_entity

    @entity = entity
    @valid = @entity.valid?
  end

  def entity
    ::Operations::Products::Clinics::InvoiceRepository.build(@entity_params)
  end
  
  def save
    # return false unless @can_current_user_create_entity
    ActiveRecord::Base.transaction do
      if @valid
        @entity.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true
        # chamar servico create nf
        Nfeio::Invoices::InvoiceCreateService.new(@entity)
        true
      else
        @data = false
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_create_entity
    if @data
      cln = ::Operations::Products::Clinics::InvoiceRepository.read(@entity)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_entity
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_entity
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_entity
    if @message
      message = "NF criada com sucesso!"
      return message
    else
      message = "Tivemos problemas para criar a NF"
      return message
    end
  end
  
  private

  def can_current_user_create_entity?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_invoices").can_current_user?
  end
  

end
