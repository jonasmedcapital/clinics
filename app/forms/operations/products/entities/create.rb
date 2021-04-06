class Operations::Products::Entities::Create
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @account_params = params.require(:account).permit(:account_id, :token)
    @product_params = params.require(:product).permit(:name, :kind, :started_at, :amount, :notes, :status)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_product = can_current_user_create_product?
    # return false unless @can_current_user_create_product
    
    @product = product
    @product.attributes = @product_params
    @product.month_started_at = @product.started_at.month
    @product.year_started_at = @product.started_at.year
    @account = account
    @valid = @product.valid?
  end

  def product
    @product ||= ::Operations::Products::EntityRepository.build(@account_params[:account_id])
  end
  
  def account
    if @account_params[:token].present?
      ::Users::Accounts::EntityRepository.find_by_token(@account_params[:token])
    elsif @account_params[:account_id].present?
      ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
    end
  end

  def save
    # return false unless @can_current_user_create_product
    ActiveRecord::Base.transaction do
      if @valid 
        @product.save
        @data = true
        @status = true
        @type = true
        @message = true
        ::Operations::Accounts::Products::UpdateService.new(@account, @product)
        true
      else
        @data = false
        @status = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_create_product
    if @data
      cln = ::Operations::Products::EntityRepository.read(@product)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_product
    if @valid
      return :created
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_product
    if @valid
      message = "Produto criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @product.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  def type
    # return "danger" unless @can_current_user_create_product
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  private

  def can_current_user_create_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", @product_params[:name]).can_current_user?
  end

end