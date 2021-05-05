class Operations::Products::Dates::CreateCalculationsService

  def initialize(date)
    @date = date
    @product = @date.product
    
    if @product.name == "medfat"
      create_receivement_calculation
    elsif @product.name == "medreturn"
      create_tax_return_calculation
    elsif @product.name == "medbooking"
      create_booking_calculation
    elsif @product.name == "medfiling"
      create_tax_filing_calculation
    elsif @product.name == "medclinic"
      create_clinic_calculation
    end
    
  end

  def create_receivement_calculation
    ::Operations::Products::Receivements::Papers::CreateCalculationService.new(@product.id, @date.id)
  end

  def create_tax_return_calculation
    ::Operations::Products::TaxReturns::Calculations::CreateCalculationService.new(@product.id, @date.id)
    ::Operations::Products::TaxReturns::Achievements::CreateAchievementService.new(@product.id, @date.id)
    ::Operations::Products::TaxReturns::Members::CreateMainMemberService.new(@product.id, @date.id)
  end

  def create_booking_calculation
    ::Operations::Products::Bookings::Calculations::CreateCalculationService.new(@product.id, @date.id)
  end

  def create_tax_filing_calculation
    ::Operations::Products::TaxFilings::Calculations::CreateCalculationService.new(@product.id, @date.id)
    ::Operations::Products::TaxFilings::Agents::CreateAgentService.new(@product.id, @date.id, @date.year)
    ::Operations::Products::TaxFilings::Summaries::CreateSummaryService.new(@product.id, @date.id)
    ::Operations::Products::TaxFilings::Journeys::ActiveJourneyService.new(@product.id, @date.id)
  end

  def create_clinic_calculation
    ::Operations::Products::Clinics::Calculations::CreateMonthlyCalculationService.new(@product, @date)
    ::Operations::Products::Clinics::Calculations::CreateYearlyCalculationService.new(@product, @date)
  end
  
  

end