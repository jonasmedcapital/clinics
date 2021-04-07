class Operations::Products::Clinics::SocialContracts::Create
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @social_contract_params = params.require(:social_contract).permit(:clinic_id, :social_capital, :shares, :social_object, :administration_clause, :profit_distribution, :tax_regime, :special_tax_regime, :legal_nature, :registry_number, :regional_tax_number, :municipal_tax_number)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_social_contract = can_current_user_create_social_contract?
    # return false unless @can_current_user_create_social_contract
    
    @social_contract = social_contract
    @valid = @social_contract.valid?
  end

  def social_contract
    @social_contract ||= ::Operations::Products::Clinics::SocialContractRepository.build(@social_contract_params)
  end

  def data
    # return cln = [] unless @can_current_user_create_social_contract
    cln = ::Operations::Products::Clinics::SocialContractRepository.read(@social_contract)
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_social_contract
    if @valid
      return :created
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_social_contract
    if @valid
      message = "Regime criado com sucesso!"
      return message
    else
      message = "Tivemos problemas parar criar o regime!"
      return message
    end
  end

  def type
    # return "danger" unless @can_current_user_create_social_contract
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    # return false unless @can_current_user_create_social_contract
    ActiveRecord::Base.transaction do
      if @valid
        @social_contract.save
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_current_user_create_social_contract?
    @can_current_user_create_social_contract ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_social_contracts").can_current_user?
  end
  
end