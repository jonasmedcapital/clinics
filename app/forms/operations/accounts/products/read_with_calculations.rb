class Operations::Accounts::Products::ReadWithCalculations
  include ActiveModel::Model

  def initialize(params)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    @current_user = current_user
    @can_current_user_read_product = can_current_user_read_product?

    return false unless @can_current_user_read_product
    @product = product
    
  end

  def current_user
    ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end

  def product
    ::Operations::Accounts::ProductRepository.find_by_account(@current_user.account.id)
  end

  def status
    return :forbidden unless @can_current_user_read_product
    :ok
  end

  def type
    return "danger" unless @can_current_user_read_product
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_product
  end
  
  def data
    return @cln = [] unless @can_current_user_read_product

    if @product.has_tax_filing
      tax_filing_calculation = ::Operations::Products::TaxFilings::CalculationRepository.all_active_by_tax_filing(@product.tax_filing_id).order(date_token: :desc).first

      if tax_filing_calculation
        @tax_filing_calculation = ::Operations::Products::TaxFilings::CalculationRepository.read(tax_filing_calculation)
      else
        @tax_filing_calculation = { active: false, name: "Declaração IRPF", journey_status_pretty: "Aguardando Ativação", total_files: 0, process_percentage: 0 }
      end

    else
      @tax_filing_calculation = { active: false, name: "Declaração IRPF", journey_status_pretty: "Aguardando Ativação", total_files: 0, process_percentage: 0 }
    end

    if @product.has_tax_return
      tax_return_calculation = ::Operations::Products::TaxReturns::CalculationRepository.all_active_by_tax_return(@product.tax_return_id).order(date_token: :desc).first
      
      if tax_return_calculation
        @tax_return_calculation = ::Operations::Products::TaxReturns::CalculationRepository.read(tax_return_calculation)
      else
        @tax_return_calculation = { active: false, name: "Planner", legal_income: 0, individual_income: 0, total_tax: 0, adjusted_tax: 0, tax_statement_pretty: "À Restituir" }
      end

      tax_return_achievement = ::Operations::Products::TaxReturns::AchievementRepository.all_active_by_tax_return(@product.tax_return_id).order(date_token: :desc).first
      
      if tax_return_achievement
        @tax_return_achievement = ::Operations::Products::TaxReturns::AchievementRepository.read(tax_return_achievement)
      else
        @tax_return_achievement = { saving_rate_goal: 0, saving_rate_real: 0 }
      end
      
    else
      @tax_return_calculation = { active: false, name: "Planner", legal_income: 0, individual_income: 0, total_tax: 0, adjusted_tax: 0, tax_statement_pretty: "À Restituir" }
      @tax_return_achievement = { saving_rate_goal: 0, saving_rate_real: 0 }
    end

    if @product.has_booking
      @booking_calculation = ::Operations::Products::Bookings::CalculationRepository.all_active_by_booking(@product.booking_id).order(date_token: :desc).first
      @booking_calculation = { active: false, name: "Livro-Caixa", total_incomes: 0, total_expenses: 0, tax_rate: 0 } unless @booking_calculation
    else
      @booking_calculation = { active: false, name: "Livro-Caixa", total_incomes: 0, total_expenses: 0, tax_rate: 0 }
    end

    if @product.has_legal
      # booking_calculation = ::Operations::Products::Clinics::CalculationRepository.all_active_by_tax_return(@product.legal_id).first
      @clinic_calculation = { active: false, name: "PJ Médica", incomes: 0, taxes: 0, real_rate: 0 }
    else
      @clinic_calculation = { active: false, name: "PJ Médica", incomes: 0, taxes: 0, real_rate: 0 }
    end

    if @product.has_receivement
      receivement_calculation = ::Operations::Products::Receivements::CalculationRepository.all_active_by_product(@product.receivement_id).order(date_token: :desc).first
      if receivement_calculation
        @receivement_calculation = ::Operations::Products::Receivements::CalculationRepository.read(receivement_calculation)
      else
        @receivement_calculation = { active: false, name: "Gestão de Recebimentos", due_papers: 0, transfer_papers: 0, paper_due_amount: 0, paper_transfer_amount: 0, average_term: 0 }
      end
    else
      @receivement_calculation = { active: false, name: "Gestão de Recebimentos", due_papers: 0, transfer_papers: 0, paper_due_amount: 0, paper_transfer_amount: 0, average_term: 0 }
    end
    


    @cln = { product: ::Operations::Accounts::ProductRepository.read(@product),
             tax_filing_calculation: @tax_filing_calculation,
             tax_return_calculation: @tax_return_calculation,
             tax_return_achievement: @tax_return_achievement,
             booking_calculation: @booking_calculation,
             clinic_calculation: @clinic_calculation,
             receivement_calculation: @receivement_calculation,
            }
    return {:cln => @cln.compact}.as_json
  end
  
  def process?
    return false unless @can_current_user_read_product
    
    if @cln.empty?
      false
    else
      true
    end
    
  end
  
  


  private

  def can_current_user_read_product?
    @can_current_user_read_product ||= ::UserPolicies.new(@current_user.id, "read", "operation_account_products").can_current_user?
  end
  
end