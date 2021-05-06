class Operations::Products::Clinics::Calculations::UpdateMonthlyCalculationService

  def initialize(receipt)
    @receipt = receipt
    @clinic = @receipt.clinic
    @date = @receipt.date
    @receipts = receipts
    @monthly_calculation = @date.monthly_calculation
    update_monthly_calculation
  end

  def receipts
    @receipts = Operations::Products::Clinics::ReceiptRepository.find_approved_receipts(@clinic.id, @date.id)
  end


  def update_monthly_calculation
    gross_total = @receipts.sum(:services_amount)
    net_receivable = @receipts.sum(:net_receivable)
    ir_total_amount = @receipts.sum(:ir_total_amount)
    pis_total_amount = @receipts.sum(:pis_total_amount)
    cofins_total_amount = @receipts.sum(:cofins_total_amount)
    csll_total_amount = @receipts.sum(:csll_total_amount)
    inss_total_amount = @receipts.sum(:inss_total_amount)
    iss_total_amount = @receipts.sum(:iss_total_amount)
    ir_amount_withheld = @receipts.sum(:ir_amount_withheld)
    pis_amount_withheld = @receipts.sum(:pis_amount_withheld)
    cofins_amount_withheld = @receipts.sum(:cofins_amount_withheld)
    csll_amount_withheld = @receipts.sum(:csll_amount_withheld)
    inss_amount_withheld = @receipts.sum(:inss_amount_withheld)
    iss_amount_withheld = @receipts.sum(:iss_amount_withheld)
    ir_amount_due = @receipts.sum(:ir_amount_due)
    csll_amount_due = @receipts.sum(:csll_amount_due)
    pis_amount_due = @receipts.sum(:pis_amount_due)
    cofins_amount_due = @receipts.sum(:cofins_amount_due)
    iss_amount_due = @receipts.sum(:iss_amount_due)
    inss_amount_due = @receipts.sum(:inss_amount_due)

    
    @monthly_calculation.update(gross_total: gross_total, net_receivable: net_receivable, ir_total_amount: ir_total_amount, pis_total_amount: pis_total_amount, cofins_total_amount: cofins_total_amount, csll_total_amount: csll_total_amount, inss_total_amount: inss_total_amount, iss_total_amount: iss_total_amount, ir_amount_withheld: ir_amount_withheld, pis_amount_withheld: pis_amount_withheld, cofins_amount_withheld: cofins_amount_withheld, csll_amount_withheld: csll_amount_withheld, inss_amount_withheld: inss_amount_withheld, iss_amount_withheld: iss_amount_withheld, ir_amount_due: ir_amount_due, csll_amount_due: csll_amount_due, pis_amount_due: pis_amount_due, cofins_amount_due: cofins_amount_due, iss_amount_due: iss_amount_due, inss_amount_due: inss_amount_due)

    Operations::Products::Clinics::Calculations::UpdateYearlyCalculationService.new(@monthly_calculation)
  end
  
end

