class Nfe::Invoices::Delete
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @invoice_params = params.require(:invoice).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    
    # @can_current_user_delete_invoice = can_current_user_delete_invoice?
    # return false unless @can_current_user_delete_invoice

    @invoice = invoice
    @invoice.attributes = @invoice_params

    @valid = @invoice.valid?
  end

  def invoice
    @invoice ||= ::Nfe::InvoiceRepository.find_by_id(@invoice_params[:id])
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def data
    # return cln = [] unless @can_current_user_delete_invoice
    cln = ::Nfe::InvoiceRepository.read @invoice
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_delete_invoice
    if @valid
      return :ok
    else
      return :bad_request
    end
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_delete_invoice
    if @valid
      message = "NF cancelada com sucesso!"
      return message
    else
      message = "Tivemos problemas para cancelar a NF"
    end
  end

  def type
    # return "danger" unless @can_current_user_delete_invoice
    if @valid
      return "success"
    else
      return "danger"
    end
  end

  def save
    # return false unless @can_current_user_delete_invoice
    ActiveRecord::Base.transaction do
      if @valid
        @invoice.save
        true
      else
        false
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def can_current_user_delete_invoice?
    @can_current_user_delete_invoice ||= ::UserPolicies.new(@current_user_params[:current_user_id], "delete", "medclinic_invoices").can_current_user?
  end
  
end