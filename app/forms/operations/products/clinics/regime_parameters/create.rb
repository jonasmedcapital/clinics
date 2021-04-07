class Operations::Products::Clinics::RegimeParameters::Create
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @regime_parameter_params = params.require(:regime_parameter).permit(:clinic_id, :monthly, :per_partner, :tax_regime, :special_tax_regime, :legal_nature, :year)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_regime_parameter = can_current_user_create_regime_parameter?
    # return false unless @can_current_user_create_regime_parameter
    
    @regime_parameter = regime_parameter
    @valid = @regime_parameter.valid?
  end

  def regime_parameter
    @regime_parameter ||= ::Operations::Products::Clinics::RegimeParameterRepository.build(@regime_parameter_params)
  end

  def data
    # return cln = [] unless @can_current_user_create_regime_parameter
    cln = ::Operations::Products::Clinics::RegimeParameterRepository.read(@regime_parameter)
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_regime_parameter
    if @valid
      return :created
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_regime_parameter
    if @valid
      message = "Regime criado com sucesso!"
      return message
    else
      message = "Tivemos problemas parar criar o regime!"
      return message
    end
  end

  def type
    # return "danger" unless @can_current_user_create_regime_parameter
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    # return false unless @can_current_user_create_regime_parameter
    ActiveRecord::Base.transaction do
      if @valid
        @regime_parameter.save
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_current_user_create_regime_parameter?
    @can_current_user_create_regime_parameter ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_regime_parameters").can_current_user?
  end
  
end