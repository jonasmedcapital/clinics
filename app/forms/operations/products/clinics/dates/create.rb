class Operations::Products::Clinics::Dates::Create
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @product_params = params.require(:product).permit(:id, :product_token)
    @date_params = params.require(:date).permit(:month, :year, :open)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_date = can_current_user_create_date?

    # return false unless @can_current_user_create_date
    @date_params = @date_params.merge({product_id: @product_params[:id]})
    
    @date = date
    @valid = @date.valid?
  end

  def date
    @date ||= ::Operations::Products::DateRepository.build(@date_params)
  end

  def product
    @product ||= ::Operations::Products::EntityRepository.find_by_id(@product_params[:id])
  end
  
  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_create_date
    cln = ::Operations::Products::DateRepository.read(@date)
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_date
    if @valid
      return :created
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_date
    if @valid
      message = "Competência criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @date.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  def type
    # return "danger" unless @can_current_user_create_date
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    # return false unless @can_current_user_create_date
    ActiveRecord::Base.transaction do
      if @valid
        @date.save
        ::Operations::Products::Dates::CreateCalculationsService.new(@date)
        # ::Operations::Products::TaxReturns::Dates::CreateDateService.new(@date)
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_current_user_create_date?
    @can_current_user_create_date ||= ::UserPolicies.new(@current_user_params[:current_user_id], "create", "medbooking_dates").can_current_user?
  end
  
end