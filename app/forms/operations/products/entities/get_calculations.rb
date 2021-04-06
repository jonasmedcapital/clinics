class Operations::Products::Entities::GetCalculations

  def initialize(params)
    @product_params = params.require(:product).permit(:name, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    @can_current_user_read_product = can_current_user_read_product?    
    return false unless @can_current_user_read_product

    if @product_params[:name] == "medreturn" && @product_params[:kind] == "receivement"
      @report = ::Operations::Products::Entities::GetCalculationsReportService.new(@product_params).get_tax_return_calculations  
    elsif @product_params[:name] == "medbooking" && @product_params[:kind] == "practice"
      @report = ::Operations::Products::Entities::GetCalculationsReportService.new(@product_params).get_booking_calculations
    elsif @product_params[:name] == "medfiling" && @product_params[:kind] == "receivement"
      @report = ::Operations::Products::Entities::GetCalculationsReportService.new(@product_params).get_tax_filing_calculations
    end
    
  end
  
  def process?
    return false unless @can_current_user_read_product
    true
  end

  def status
    return :forbidden unless @can_current_user_read_product
    :ok
  end
  
  def data
    return cln = [] unless @can_current_user_read_product

    return {:cln => @report}.as_json
  end

  def message
    return message = "" unless @can_current_user_read_product
  end

  def type
    return "danger" unless @can_current_user_read_product
  end

  private

  def can_current_user_read_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", @product_params[:name]).can_current_user?
  end
  


end