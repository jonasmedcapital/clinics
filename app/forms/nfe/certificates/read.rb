class Nfe::Certificates::Read

  def initialize(params)
    @certificate_params = params.require(:certificate).permit(:id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_certificate = can_current_user_read_certificate?
    # return false unless @can_current_user_read_certificate

    @certificate = certificate
  end

  def certificate
    ::Nfe::CertificateRepository.find_by_id(@certificate_params[:id])
  end

  def status
    # return :forbidden unless @can_current_user_read_certificate
    @status
  end

  def process?
    # return false unless @can_current_user_read_certificate
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_certificate
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_certificate
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_certificate
    cln = ::Nfe::CertificateRepository.read(@certificate)

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

  def can_current_user_read_certificate?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "medclinic_certificates").can_current_user?
  end

end