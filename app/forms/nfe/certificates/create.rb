class Nfe::Certificates::Create

  def initialize(params)
    @certificate_params = params.require(:certificate).permit(:clinic_id, :expiration_date, :kind, :password)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_certificate = can_current_user_create_certificate?
    # return false unless @can_current_user_create_certificate

    @certificate = certificate
    @valid = @certificate.valid?
  end

  def certificate
    ::Nfe::CertificateRepository.build(@certificate_params)
  end
  
  def save
    # return false unless @can_current_user_create_certificate
    ActiveRecord::Base.transaction do
      if @valid
        @certificate.save
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
    # return cln = [] unless @can_current_user_create_certificate
    if @data
      cln = ::Nfe::CertificateRepository.read(@certificate)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_certificate
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_certificate
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_certificate
    if @message
      message = ""
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @certificate.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_certificate?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_certificates").can_current_user?
  end

end
