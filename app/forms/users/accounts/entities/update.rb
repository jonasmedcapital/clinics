class Users::Accounts::Entities::Update

  def initialize(params)
    @account_params = params.require(:account).permit(:id, :active, :name, :cpf, :birthdate, :sex, :notes)
    @kind_params = params.require(:kind).permit(:kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

    @can_current_user_update_account = can_current_user_update_account?

    return false unless @can_current_user_update_account
    
    @account = account
    @account.attributes = @account_params
    @account.kind << @kind_params[:kind] unless @account.kind.include?(@kind_params[:kind])
    @valid = @account.valid?
  end

  def account
    ::Users::Accounts::EntityRepository.find_by_id(@account_params[:id])
  end

  def process?
    return false unless @can_current_user_update_account
    true
  end

  def status
    return :forbidden unless @can_current_user_update_account
    if @valid
      return :ok
    else
      return :bad_request
    end
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_update_account
    if @valid
      message = "Conta atualizada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @account.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  def type
    return "danger" unless @can_current_user_update_account
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    return false unless @can_current_user_update_account
    ActiveRecord::Base.transaction do
      if @valid

        if @account.user.present?
          update_account_user_informations
        end
        
        @account.save
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  def data
    return cln = [] unless @can_current_user_update_account
    if @valid
      cln = ::Users::Accounts::EntityRepository.read(@account)
    else
      cln = []
    end
    
    return {:cln => cln}.as_json
  end

  private

  def can_current_user_update_account?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", @current_user_params[:feature]).can_current_user?
  end

  def update_account_user_informations
    user = @account.user
    @account.changed.each do |attr|
      user.send("#{attr}=", @account.send(attr)) if user.respond_to?(attr)
    end
    user.save
  end
  

end