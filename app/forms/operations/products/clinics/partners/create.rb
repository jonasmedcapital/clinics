class Operations::Products::Clinics::Partners::Create

  def initialize(params)
    @partner_params = params.require(:partner).permit(:clinic_id, :account_id, :name, :cpf, :financial, :operational, :admnistrative, :doctor, :legal, :technical, :shares, :entried_at, :exited_at, :exited_description)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_partner = can_current_user_create_partner?
    # return false unless @can_current_user_create_partner

    @partner = partner
    @valid = @partner.valid?
  end

  def partner
    ::Operations::Products::Clinics::PartnerRepository.build(@partner_params)
  end

  def current_user
    ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def save
    # return false unless @can_current_user_create_partner
    ActiveRecord::Base.transaction do
      if @valid
        @partner.save
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
    # return cln = [] unless @can_current_user_create_partner
    if @data
      cln = ::Operations::Products::Clinics::PartnerRepository.read(@partner)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_partner
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_partner
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_partner
    if @valid
      message = "Tomador criada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @partner.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_partner?
    @can_current_user_create_partner ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medclinic_partners").can_current_user?
  end
  
end
