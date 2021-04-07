class Operations::Products::Clinics::Receipts::List

  def initialize(params)
    @receipt_params = params.require(:receipt).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_receipt = can_current_user_list_receipt?
    # return false unless @can_current_user_list_receipt

    @receipts = receipts
  end

  def receipts
    ::Operations::Products::Clinics::ReceiptRepository.all_active_clinic(@receipt_params[:clinic_id])
  end

 def status
    # return :forbidden unless @can_current_user_list_receipt
    @status
  end

  def process?
    # return false unless @can_current_user_list_receipt
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_receipt
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_receipt
    @message
  end

  def data
    cln = ::Operations::Products::Clinics::ReceiptRepository.list_all(@receipts)

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

  def can_current_user_list_receipt?
    @can_current_user_list_receipt ||= ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_receipts").can_current_user?
  end

end