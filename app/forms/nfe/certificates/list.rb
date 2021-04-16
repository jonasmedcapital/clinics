class Nfe::Certificates::List

  def initialize(params)
    @certificate_params = params.require(:certificate).permit(:clinic_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_certificate = can_current_user_list_certificate?
    # return false unless @can_current_user_list_certificate

    @certificates = certificates
  end

  def certificates
    ::Nfe::CertificateRepository.all_active_by_tax_filing(@certificate_params[:tax_filing_id])
  end

  def status
    # return :forbidden unless @can_current_user_list_certificate
    @status
  end

  def process?
    # return false unless @can_current_user_list_certificate
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_certificate
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_certificate
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_certificate
    cln = ::Nfe::CertificateRepository.list_all(@certificates)

    if cln.empty?
      @status = :ok
      @process = false
      @message = "Não há Arquivos para Declaração IRPF"
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

  def can_current_user_list_certificate?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medclinic_certificates").can_current_user?
  end

end