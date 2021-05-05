class Operations::Products::Clinics::Receipts::Create

  attr_accessor :status, :type, :message

  def initialize(params)
    @receipt_params = params.require(:receipt).permit(:clinic_id,:date_id,:bank_id,:taker_id,:taker_type,:taker_name,:taker_federal_tax_number,:taker_municipal_tax_number,:taker_email,:taker_country,:taker_postal_code,:taker_street,:taker_number,:taker_complement,:taker_district,:taker_city_code,:taker_city_name,:taker_state,:city_service_code,:federal_service_code,:cnae_code,:description,:services_amount,:rps_serial_number,:issued_on,:rps_number,:taxation_type,:iss_rate,:iss_tax_amount,:deductions_amount,:unconditioned_amount,:conditioned_amount,:others_amount_withheld,:source,:version,:total_rate,:additional_information,:service_state,:service_city_code,:service_city_name,:ir_amount_withheld,:pis_amount_withheld,:cofins_amount_withheld,:csll_amount_withheld,:inss_amount_withheld,:iss_amount_withheld,:ir_total_amount,:pis_total_amount,:cofins_total_amount,:csll_total_amount,:inss_total_amount,:iss_total_amount,:ir_amount_due,:csll_amount_due,:pis_amount_due,:cofins_amount_due,:iss_amount_due,:inss_amount_due,:nominal_aliquot,:ir_aliquot,:csll_aliquot,:pis_aliquot,:cofins_aliquot,:inss_aliquot,:iss_aliquot,:effective_aliquot,:ir_effective_aliquot,:csll_effective_aliquot,:pis_effective_aliquot,:cofins_effective_aliquot,:inss_effective_aliquot,:iss_effective_aliquot,:total_due,:total_withheld,:total_withheld_parcial,:net_receivable,:status,:tax_regime,:value_per_partner,:default_withheld,:iss_aliquot_check, :payment_installments)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_create_receipt = can_current_user_create_receipt?
    # return false unless @can_current_user_create_receipt

    @receipt = receipt
    @valid = @receipt.valid?
  end

  def receipt
    ::Operations::Products::Clinics::ReceiptRepository.build(@receipt_params)
  end
  
  def save
    # return false unless @can_current_user_create_receipt
    ActiveRecord::Base.transaction do
      if @valid
        @receipt.save
        Operations::Products::Clinics::Calculations::UpdateMonthlyCalculationService.new(@receipt)
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true
        # servico para calculation
        # Operations::Products::Clinics::Receipts::UpdateCalculationsService.new(@receipt)
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
    # return cln = [] unless @can_current_user_create_receipt
    if @data
      cln = ::Operations::Products::Clinics::ReceiptRepository.read(@receipt)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_receipt
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_receipt
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_receipt
    if @message
      message = "Recibo criado com sucesso!"
      return message
    else
      message = "Tivemos problemas para criar o recibo"
      return message
    end
  end
  
  private

  def can_current_user_create_receipt?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_receipts").can_current_user?
  end
  

end
