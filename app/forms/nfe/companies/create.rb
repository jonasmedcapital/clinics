class Nfe::Companies::Create

  attr_accessor :status, :type, :message

  def initialize(params)
    @company_params = params.require(:company).permit(:clinic_id, :company_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_create_company = can_current_user_create_company?
    # return false unless @can_current_user_create_company

    @company = company
    @valid = @company.valid?
  end

  def company
    ::Nfe::CompanyRepository.build(@company_params)
  end
  
  def save
    # return false unless @can_current_user_create_company
    ActiveRecord::Base.transaction do
      nfe_company_id = Nfeio::Companies::CompanyCreateService.new(@company)
      
      if nfe_company_id
        @company.nfe_company_id = nfe_company_id
      end

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
      cln = ::Nfe::CompanyRepository.read(@company)
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
      message = "Empresa criada com sucesso!"
      return message
    else
      message = "Tivemos problemas para criar a empresa"
      return message
    end
  end
  
  private

  def can_current_user_create_company?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_company").can_current_user?
  end
  

end
