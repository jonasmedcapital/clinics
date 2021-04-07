class Operations::Products::Clinics::Apurations::PresumedProfits::CreateQuarterApurationService

  def initialize(apuration)
    @apuration = apuration
    @clinic = apuration.clinic
    @date = @apuration.product_date
    @year = @date.year
    @first_quarter_bool = false
    @second_quarter_bool = false
    @third_quarter_bool = false
    @fourth_trimester_bool = false
    @receipts = Array.new

    @first_quarter = [1,2,3]
    @second_quarter = [4,5,6]
    @third_quarter = [7,8,9]
    @fourth_trimester = [10,11,12]
  end

  def create_apuration
    if !@apuration.monthly
      quarter_date_find
      if @apuration.per_partner
        @apuration.clinic_id = @clinic.id
        @apuration.date_id = @date.id
        @apuration.monthly = false
        @apuration.per_partner = true
        @apuration.partner_id = @apuration.partner_id
        
        @apuration.irpj_paid = @receipts.sum(:ir_amount_withheld)
        @apuration.csll_paid = @receipts.sum(:csll_amount_withheld)
        @apuration.total_paid = @apuration.irpj_paid + @apuration.csll_paid

        @apuration.irpj_to_pay = @receipts.sum(:ir_amount_due)
        @apuration.csll_to_pay = @receipts.sum(:csll_amount_due)
        @apuration.total_to_pay = @apuration.irpj_to_pay + @apuration.csll_to_pay
        
        @apuration.irpj_amount = @receipts.sum(:ir_total_amount)
        @apuration.csll_amount = @receipts.sum(:csll_total_amount)
        @apuration.total_amount = @apuration.irpj_amount + @apuration.csll_amount 
        
      else
        @apuration.clinic_id = @clinic.id
        @apuration.date_id = @date.id
        @apuration.monthly = false
        @apuration.per_partner = false
        
        @apuration.irpj_paid = @receipts.sum(:ir_amount_withheld)
        @apuration.csll_paid = @receipts.sum(:csll_amount_withheld)
        @apuration.total_paid = @apuration.irpj_paid + @apuration.csll_paid

        @apuration.irpj_to_pay = @receipts.sum(:ir_amount_due)
        @apuration.csll_to_pay = @receipts.sum(:csll_amount_due)
        @apuration.total_to_pay = @apuration.irpj_to_pay + @apuration.csll_to_pay
        
        @apuration.irpj_amount = @receipts.sum(:ir_total_amount)
        @apuration.csll_amount = @receipts.sum(:csll_total_amount)
        @apuration.total_amount = @apuration.irpj_amount + @apuration.csll_amount 
        
      end
    end
  end

  def receipts_quarter_find
    if @first_quarter.include?(@date.month)
      @first_quarter_bool = true
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 1).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 2).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 3).first.receipts.where(active: true, status: "approved")
    elsif @second_quarter.include?(@date.month).first
      @second_quarter_bool = true
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 4).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 5).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 6).first.receipts.where(active: true, status: "approved")
    elsif @third_quarter.include?(@date.month).first
      @third_quarter_bool = true
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 7).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 8).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 9).first.receipts.where(active: true, status: "approved")
    elsif @fourth_trimester.include?(@date.month).first
      @fourth_trimester_bool = true
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 10).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 11).first.receipts.where(active: true, status: "approved")
      @receipts << Operation::Product::Date.where(active: true, year: @year, product_id: @clinic.id, month: 12).first.receipts.where(active: true, status: "approved")
    end
  end
  
end