class Operations::Products::Clinics::YearlyCalculations::Update

  def initialize(params)
    @calculation_params = params.require(:calculation).permit(:id, :gross_total, :net_receivable, :ir_total_amount, :pis_total_amount, :cofins_total_amount, :csll_total_amount, :inss_total_amount, :iss_total_amount, :ir_amount_withheld, :pis_amount_withheld, :cofins_amount_withheld, :csll_amount_withheld, :inss_amount_withheld, :iss_amount_withheld, :ir_amount_due, :csll_amount_due, :pis_amount_due, :cofins_amount_due, :iss_amount_due, :inss_amount_due)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_calculation = can_current_user_create_calculation?
    # return false unless @can_current_user_create_calculation

    @calculation = calculation
    @calculation.attributes = @calculation_params
    @valid = @calculation.valid?
  end

  def calculation
    @calculation ||= ::Operations::Products::Clinics::YearlyCalculationRepository.find_by_id(@calculation_params[:id])
  end

  def current_user
    ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def save
    # return false unless @can_current_user_create_calculation
    ActiveRecord::Base.transaction do
      if @valid
        @calculation.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true
        true
      else
        @data = true
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_create_calculation
    if @data
      cln = ::Operations::Products::Clinics::YearlyCalculationRepository.read(@calculation)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_calculation
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_calculation
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_calculation
    if @valid
      message = "Tomador criada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @calculation.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_calculation?
    @can_current_user_create_calculation ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_calculations").can_current_user?
  end
  
end
