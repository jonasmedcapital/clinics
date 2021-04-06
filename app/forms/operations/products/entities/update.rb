class Operations::Products::Entities::Update
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @product_params = params.require(:product).permit(:id, :name, :kind, :started_at, :amount, :notes, :status)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    @can_current_user_update_product = can_current_user_update_product?
    return false unless @can_current_user_update_product
    
    @product = product
    @product.attributes = @product_params
    @product.month_started_at = product.started_at.month
    @product.year_started_at = product.started_at.year

    @valid = @product.valid?
  end

  def product
    ::Operations::Products::EntityRepository.find_by_id(@product_params[:id])
  end

  def save
    return false unless @can_current_user_update_product
    ActiveRecord::Base.transaction do
      if @valid 
        @product.save
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
    return cln = [] unless @can_current_user_update_product
    if @data
      cln = ::Operations::Products::EntityRepository.read(@product)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    return :forbidden unless @can_current_user_update_product
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    return "danger" unless @can_current_user_update_product
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    return message = "A ação não é permitida" unless @can_current_user_update_product
    if @message
      message = "Status da Produto atualizado com sucesso!"
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

  private

  def can_current_user_update_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", @product_params[:name]).can_current_user?
  end

end