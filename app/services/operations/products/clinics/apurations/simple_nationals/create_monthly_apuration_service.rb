class Operations::Products::Clinics::Apurations::SimpleNationals::CreateMonthlyApurationService

  def initialize(apuration)
    @apuration = apuration
    @date = @apuration.product_date
  end

  def create_apuration
    if @apuration.monthly
      if @apuration.per_partner
        @receipts = Operation::Product::Clinic::Invoice::Receipt.where(active: true, clinic_id: @apuration.clinic_id, date_id: @apuration.date_id, partner_id: @apuration.partner_id, status: "approved")
        @apuration.clinic_id = @receipts.sum(:)
        @apuration.date_id = @receipts.sum(:)
        @apuration.monthly = true
        @apuration.per_partner = true
        @apuration.partner_id = @apuration.partner_id
        
        @apuration.irpj_paid = @receipts.sum(:ir_amount_withheld)
        @apuration.csll_paid = @receipts.sum(:csll_amount_withheld)
        @apuration.pis_paid = @receipts.sum(:pis_amount_withheld)
        @apuration.cofins_paid = @receipts.sum(:cofins_amount_withheld)
        @apuration.iss_paid = @receipts.sum(:iss_amount_withheld)
        @apuration.inss_paid = @receipts.sum(:inss_amount_withheld)
        # @apuration.total_paid = @receipts.sum(:total_amount_withheld)
        
        @apuration.irpj_to_pay = @receipts.sum(:ir_amount_due)
        @apuration.csll_to_pay = @receipts.sum(:csll_amount_due)
        @apuration.pis_to_pay = @receipts.sum(:pis_amount_due)
        @apuration.cofins_to_pay = @receipts.sum(:cofins_amount_due)
        @apuration.iss_to_pay = @receipts.sum(:iss_amount_due)
        @apuration.inss_to_pay = @receipts.sum(:inss_amount_due)
        # @apuration.total_to_pay = @receipts.sum(:total_amount_due)
        
        @apuration.irpj_amount = @receipts.sum(:ir_total_amount)
        @apuration.csll_amount = @receipts.sum(:csll_total_amount)
        @apuration.pis_amount = @receipts.sum(:pis_total_amount)
        @apuration.cofins_amount = @receipts.sum(:cofins_total_amount)
        @apuration.iss_amount = @receipts.sum(:iss_total_amount)
        @apuration.inss_amount = @receipts.sum(:inss_total_amount)
        # @apuration.total_amount = @receipts.sum(:total_total_amount)

        @apuration.revenue = @receipts.sum(:)
        @apuration.discounts = @receipts.sum(:)
        @apuration.value_net_of_taxes = @receipts.sum(:)
        @apuration.last_twelve_months = @receipts.sum(:)

      else
        @receipts = Operation::Product::Clinic::Invoice::Receipt.where(active: true, clinic_id: @apuration.clinic_id, date_id: @apuration.date_id, status: "approved")
        @apuration.clinic_id = @receipts.sum(:)
        @apuration.date_id = @receipts.sum(:)
        @apuration.monthly = true
        @apuration.per_partner = false
        
        @apuration.irpj_paid = @receipts.sum(:ir_amount_withheld)
        @apuration.csll_paid = @receipts.sum(:csll_amount_withheld)
        @apuration.pis_paid = @receipts.sum(:pis_amount_withheld)
        @apuration.cofins_paid = @receipts.sum(:cofins_amount_withheld)
        @apuration.iss_paid = @receipts.sum(:iss_amount_withheld)
        @apuration.inss_paid = @receipts.sum(:inss_amount_withheld)
        # @apuration.total_paid = @receipts.sum(:total_amount_withheld)
        
        @apuration.irpj_to_pay = @receipts.sum(:ir_amount_due)
        @apuration.csll_to_pay = @receipts.sum(:csll_amount_due)
        @apuration.pis_to_pay = @receipts.sum(:pis_amount_due)
        @apuration.cofins_to_pay = @receipts.sum(:cofins_amount_due)
        @apuration.iss_to_pay = @receipts.sum(:iss_amount_due)
        @apuration.inss_to_pay = @receipts.sum(:inss_amount_due)
        # @apuration.total_to_pay = @receipts.sum(:total_amount_due)
        
        @apuration.irpj_amount = @receipts.sum(:ir_total_amount)
        @apuration.csll_amount = @receipts.sum(:csll_total_amount)
        @apuration.pis_amount = @receipts.sum(:pis_total_amount)
        @apuration.cofins_amount = @receipts.sum(:cofins_total_amount)
        @apuration.iss_amount = @receipts.sum(:iss_total_amount)
        @apuration.inss_amount = @receipts.sum(:inss_total_amount)
        # @apuration.total_amount = @receipts.sum(:total_amount)

        @apuration.revenue = @receipts.sum(:)
        @apuration.discounts = @receipts.sum(:)
        @apuration.value_net_of_taxes = @receipts.sum(:)
        @apuration.last_twelve_months = @receipts.sum(:)

      end
    end
  end

  # ou usar calculation
  # calcular faixa
  
end