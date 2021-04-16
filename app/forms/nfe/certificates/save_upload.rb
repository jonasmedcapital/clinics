class Nfe::Certificates::SaveUpload

  def initialize(params)
    @current_user_id = params.require(:current_user_id)
    @certificate_id = params["certificate_id"]

    if params["file"] == "" || params["file"] == "undefined"
      @file = false
    else
      @file = params["file"]
    end
    
    # @can_current_user_update_certificate = can_current_user_update_certificate?
    # return false unless @can_current_user_update_certificate

    @certificate = certificate
    
    if @file
      @certificate.file = @file
    end

    @valid = @certificate.valid?
  end

  def certificate
    ::Nfe::CertificateRepository.find_by_id(@certificate_id)
  end
  
  def save
    # return false unless @can_current_user_update_certificate
    ActiveRecord::Base.transaction do
      if @valid
        @certificate.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true
        Nfeio::Companies::CertificateUploadService.new(@certificate, @file)
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
    # return cln = [] unless @can_current_user_update_certificate
    if @data
      cln = ::Nfe::CertificateRepository.read(@certificate)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_certificate
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_certificate
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_certificate
    if @valid
      message = "Documento salvo com sucesso!"
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

  def can_current_user_update_certificate?
    ::UserPolicies.new(@current_user_id, "update", "medclinic_certificates").can_current_user?
  end

end

