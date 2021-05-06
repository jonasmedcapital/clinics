class Operations::Products::Clinics::Calculations::UpdateYearlyCalculationService

  def initialize(monthly_calculation)
    @monthly_calculation = monthly_calculation
    @clinic = @monthly_calculation.clinic
    @regime_parameter = @clinic.clinic_regime_parameter
    @monthly_calculations = monthly_calculations
    update_yearly_calculation
  end

  def monthly_calculations
    start_month = @regime_parameter.started_at.month
    if Time.zone.now.year == @monthly_calculation.year
      end_month = Time.zone.now.month
    else
      end_month = 12
    end
    @monthly_calculations = Operations::Products::Clinics::MonthlyCalculationRepository.find_year_month(@clinic.id, @monthly_calculation.year, start_month, end_month)
  end

  def update_yearly_calculation
    gross_total = @monthly_calculations.sum(:gross_total)
    net_receivable = @monthly_calculations.sum(:net_receivable)
    ir_total_amount = @monthly_calculations.sum(:ir_total_amount)
    pis_total_amount = @monthly_calculations.sum(:pis_total_amount)
    cofins_total_amount = @monthly_calculations.sum(:cofins_total_amount)
    csll_total_amount = @monthly_calculations.sum(:csll_total_amount)
    inss_total_amount = @monthly_calculations.sum(:inss_total_amount)
    iss_total_amount = @monthly_calculations.sum(:iss_total_amount)
    ir_amount_withheld = @monthly_calculations.sum(:ir_amount_withheld)
    pis_amount_withheld = @monthly_calculations.sum(:pis_amount_withheld)
    cofins_amount_withheld = @monthly_calculations.sum(:cofins_amount_withheld)
    csll_amount_withheld = @monthly_calculations.sum(:csll_amount_withheld)
    inss_amount_withheld = @monthly_calculations.sum(:inss_amount_withheld)
    iss_amount_withheld = @monthly_calculations.sum(:iss_amount_withheld)
    ir_amount_due = @monthly_calculations.sum(:ir_amount_due)
    csll_amount_due = @monthly_calculations.sum(:csll_amount_due)
    pis_amount_due = @monthly_calculations.sum(:pis_amount_due)
    cofins_amount_due = @monthly_calculations.sum(:cofins_amount_due)
    iss_amount_due = @monthly_calculations.sum(:iss_amount_due)
    inss_amount_due = @monthly_calculations.sum(:inss_amount_due)
    
    @yearly_calculation = Operations::Products::Clinics::YearlyCalculationRepository.find_year(@clinic.id, @monthly_calculation.year).first
    @yearly_calculation.update(gross_total: gross_total, net_receivable: net_receivable, ir_total_amount: ir_total_amount, pis_total_amount: pis_total_amount, cofins_total_amount: cofins_total_amount, csll_total_amount: csll_total_amount, inss_total_amount: inss_total_amount, iss_total_amount: iss_total_amount, ir_amount_withheld: ir_amount_withheld, pis_amount_withheld: pis_amount_withheld, cofins_amount_withheld: cofins_amount_withheld, csll_amount_withheld: csll_amount_withheld, inss_amount_withheld: inss_amount_withheld, iss_amount_withheld: iss_amount_withheld, ir_amount_due: ir_amount_due, csll_amount_due: csll_amount_due, pis_amount_due: pis_amount_due, cofins_amount_due: cofins_amount_due, iss_amount_due: iss_amount_due, inss_amount_due: inss_amount_due)
  end
  
end

