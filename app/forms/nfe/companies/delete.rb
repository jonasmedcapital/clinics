class Nfe::Comapnies::Delete
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @company_params = params.require(:company).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_delete_company = can_current_user_delete_company?
    # return false unless @can_current_user_delete_company

    @company = company
    @company.attributes = @company_params

    @valid = @company.valid?
  end

  def company
    @company ||= ::Nfe::ComapnyRepository.find_by_id(@company_params[:id])
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_delete_company
    cln = ::Nfe::ComapnyRepository.read @company
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_delete_company
    if @valid
      return :ok
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_delete_company
    if @valid
      message = "NF cancelada com sucesso!"
      return message
    else
      message = "Tivemos problemas para cancelar a NF"
    end
  end

  def type
    # return "danger" unless @can_current_user_delete_company
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    # return false unless @can_current_user_delete_company
    ActiveRecord::Base.transaction do
      if @valid
        @company.save
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_current_user_delete_company?
    @can_current_user_delete_company ||= ::UserPolicies.new(@current_user_params[:current_user_id], "delete", "medclinic_invoices").can_current_user?
  end
  
end