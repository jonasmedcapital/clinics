class Operations::Products::Clinics::Takers::Create

  def initialize(params)
    @taker_params = params.require(:taker).permit(:clinic_id, :taker_id, :taker_type, :taker_number, :taker_name)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_taker = can_current_user_create_taker?
    # return false unless @can_current_user_create_taker
    
    if @taker_params[:taker_type] == "account"
      @account_params = params.require(:account).permit(:id, :kind, :name, :cpf, :sex, :birthdate)
      
      if @account_params[:id].present?
        @taker_params = @taker_params.merge({ taker_id: @account_params[:id] })
      else
        @account = ::Users::Accounts::CreateEntityService.new(@account_params).create_account
        @taker_params = @taker_params.merge({ taker_id: @account.id })
      end

    elsif @taker_params[:taker_type] == "company"
      @company_params = params.require(:company).permit(:id, :name, :trade_name, :cnpj, :kind, :subkind)
      
      if @company_params[:id].present?
        @taker_params = @taker_params.merge({ taker_id: @company_params[:id] })
      else
        @company = ::Users::Companies::CreateEntityService.new(@company_params).create_company
        @taker_params = @taker_params.merge({ taker_id: @company.id })
      end
    end

    @taker = taker
    @valid = @taker.valid?
  end

  def taker
    ::Operations::Products::Clinics::TakerRepository.build(@taker_params)
  end

  def current_user
    ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def save
    # return false unless @can_current_user_create_taker
    ActiveRecord::Base.transaction do
      if @valid
        @taker.save
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
    # return cln = [] unless @can_current_user_create_taker
    if @data
      cln = ::Operations::Products::Clinics::TakerRepository.read(@taker)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_taker
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_taker
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_taker
    if @valid
      message = "Tomador criada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @taker.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_taker?
    @can_current_user_create_taker ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_takers").can_current_user?
  end
  
end
