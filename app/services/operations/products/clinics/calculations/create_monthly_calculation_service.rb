class Operations::Products::Clinics::Calculations::CreateMonthlyCalculationService

  def initialize(product, date)
    @clinic = product
    @date = date
    @monthly_calculation = monthly_calculation
    @monthly_calculation.save
  end

  def monthly_calculation
    obj = Calculation.new(@clinic.id, @date.id, @date.month, @date.year, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    ::Operations::Products::Clinics::MonthlyCalculationRepository.build(obj)
  end

  Calculation = Struct.new(
    :clinic_id,
    :date_id,
    :month,
    :year,
    :gross_total,
    :net_receivable,
    :ir_total_amount,
    :pis_total_amount,
    :cofins_total_amount,
    :csll_total_amount,
    :inss_total_amount,
    :iss_total_amount,
    :ir_amount_withheld,
    :pis_amount_withheld,
    :cofins_amount_withheld,
    :csll_amount_withheld,
    :inss_amount_withheld,
    :iss_amount_withheld,
    :ir_amount_due,
    :csll_amount_due,
    :pis_amount_due,
    :cofins_amount_due,
    :iss_amount_due,
    :inss_amount_due
  )
  
end

# @receipts = @date.receipts
# gross_total = @receipts.sum(:services_amount)
# net_receivable = @receipts.sum(:net_receivable)
# ir_total_amount = @receipts.sum(:ir_total_amount)
# pis_total_amount = @receipts.sum(:pis_total_amount)
# cofins_total_amount = @receipts.sum(:cofins_total_amount)
# csll_total_amount = @receipts.sum(:csll_total_amount)
# inss_total_amount = @receipts.sum(:inss_total_amount)
# iss_total_amount = @receipts.sum(:iss_total_amount)
# ir_amount_withheld = @receipts.sum(:ir_amount_withheld)
# pis_amount_withheld = @receipts.sum(:pis_amount_withheld)
# cofins_amount_withheld = @receipts.sum(:cofins_amount_withheld)
# csll_amount_withheld = @receipts.sum(:csll_amount_withheld)
# inss_amount_withheld = @receipts.sum(:inss_amount_withheld)
# iss_amount_withheld = @receipts.sum(:iss_amount_withheld)
# ir_amount_due = @receipts.sum(:ir_amount_due)
# csll_amount_due = @receipts.sum(:csll_amount_due)
# pis_amount_due = @receipts.sum(:pis_amount_due)
# cofins_amount_due = @receipts.sum(:cofins_amount_due)
# iss_amount_due = @receipts.sum(:iss_amount_due)
# inss_amount_due = @receipts.sum(:inss_amount_due)