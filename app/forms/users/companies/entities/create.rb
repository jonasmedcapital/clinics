class Users::Companies::Entities::Create

  def initialize(params)
    @company_params = params.require(:company).permit(:id, :active, :name, :trade_name, :cnpj, :opened_at, :subkind, :notes)
    @kind_params = params.require(:kind).permit(:kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

    # @can_current_user_create_company = can_current_user_create_company?
    # return false unless @can_current_user_create_company
    
    @company = company
    @company.attributes = @company_params
    if @company_params[:subkind].present?
      company.subkind = [@company_params[:subkind]]
    end

    @company.kind << @kind_params[:kind] unless @company.kind.include?(@kind_params[:kind])

    @valid = @company.valid?
  end

  def company
    ::Users::Companies::EntityRepository.build(@kind_params[:kind])
  end

  def save
    # return false unless @can_current_user_create_company
    ActiveRecord::Base.transaction do
      if @valid
        @company.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

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
    # return cln = [] unless @can_current_user_create_company
    if @data
      cln = ::Users::Companies::EntityRepository.read(@company)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_company
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_company
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_company
    if @message
      message = "Empresa atualizada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @company.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_company?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", @current_user_params[:feature]).can_current_user?
  end

end