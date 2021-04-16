class Nfe::Invoices::Create

  attr_accessor :status, :type, :message

  def initialize(params)
    @invoice_params = params.require(:invoice).permit(:clinic_id, :company_id, :receipt_id, :nfe_invoice_id, :status)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_create_invoice = can_current_user_create_invoice?
    # return false unless @can_current_user_create_invoice

    @invoice = invoice
    @valid = @invoice.valid?
  end

  def invoice
    ::Nfe::InvoiceRepository.build(@invoice_params)
  end
  
  def save
    # return false unless @can_current_user_create_invoice
    ActiveRecord::Base.transaction do
      if @valid
        @invoice.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true
        # chamar servico create nf
        Nfeio::Invoices::InvoiceCreateService.new(@invoice)
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
    # return cln = [] unless @can_current_user_create_invoice
    if @data
      cln = ::Nfe::InvoiceRepository.read(@invoice)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_invoice
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_invoice
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_invoice
    if @message
      message = "NF criada com sucesso!"
      return message
    else
      message = "Tivemos problemas para criar a NF"
      return message
    end
  end
  
  private

  def can_current_user_create_invoice?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_invoices").can_current_user?
  end
  

end
