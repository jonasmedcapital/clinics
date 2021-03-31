class Users::Companies::Entities::Read
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @company_params = params.require(:company).permit(:id, :cnpj, :active, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

    @can_current_user_read_company = can_current_user_read_company?

    return false unless @can_current_user_read_company
    @company = company
  end

  def company
    if @company_params[:cnpj].present?
      ::Users::Companies::EntityRepository.find_by_cnpj(@company_params[:cnpj])
      # ::Users::Companies::EntityRepository.find_by_cnpj_or_initialize_by_cnpj_and_kind(@company_params[:cnpj], @company_params[:kind])
    elsif @company_params[:id].present?
      ::Users::Companies::EntityRepository.find_by_id(@company_params[:id])
    end
  end
  
  def process?
    return false unless @can_current_user_read_company
    true
  end

  def status
    return :forbidden unless @can_current_user_read_company
    :ok
  end

  def data
    return cln = [] unless @can_current_user_read_company
    if @company.present?
      cln = ::Users::Companies::EntityRepository.read @company
    else
      cln = []
    end
    return {:cln => cln}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_company
  end

  def type
    return "danger" unless @can_current_user_read_company
  end

  private

  def can_current_user_read_company?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", @current_user_params[:feature]).can_current_user?
  end
  


end