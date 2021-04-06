class Operations::Products::EntityRepository < Base
  
  def self.build(account_id)
    entity.new(account_id: account_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_cpf(cpf, name, kind)
    account = ::Users::Accounts::EntityRepository.find_by_cpf(cpf)
    products = account.products
    product = mapper.map(products.where(name: name, kind: kind).first)
    product
  end

  def self.find_by_token(token)
    product = entity.where(uniq_product: token).first
    product = mapper.map(product)
    product
  end

  def self.list_by_name(name)
    entity.where(active: true, name: name)
  end

  def self.report_with_permissions(current_user, feature)
    mapper.report_with_permissions(entity, current_user, feature)
  end
  
  def self.all_active_by_account_and_name(account_id, name)
    entity.where(active: true, account_id: account_id, name: name)
  end

  def self.all_active_by_name_and_kind(name, kind)
    if name == "medfiling"
      entity.where(active: true, name: name, kind: kind).includes(:account, :tax_filing_calculations)
    elsif name == "medbooking"
      entity.where(active: true, name: name, kind: kind).includes(:account, :booking_calculations)
    else
      entity.where(active: true, name: name, kind: kind)
    end
  end
  
  def self.list_all_active_by_account_and_name(account_id, name)
    products = entity.where(active: true, account_id: account_id, name: name)
    mapper.map_collection products
  end

  def self.list_with_permissions(products, product_name, current_user)
    mapper.map_all_with_permissions(products, product_name, current_user)
  end

  def self.list_all(products)
    mapper.map_all(products)
  end
  
  def self.read(product)
    mapper.map(product)
  end

  def self.read_with_permissions(product, product_name, current_user)
    mapper.map_with_permissions(product, product_name, current_user)
  end 

  def self.clean_medbooking(booking)
    if Rails.env == "development"
      Operation::Product::Booking::Receipt.where(booking_id: booking.id).destroy_all
      Operation::Product::Booking::Payment.where(booking_id: booking.id).destroy_all
      Operation::Product::Booking::Provision.where(booking_id: booking.id).destroy_all
      Operation::Product::Booking::Transaction.where(booking_id: booking.id).destroy_all
      # Operations::Products::Bookings::Calculations::CleanCalculationService.new(booking)
      Operation::Product::Date.where(product_id: booking.id).destroy_all
    end
  end

  def self.clean_medreturn(tax_return)
    if Rails.env == "development"
      Operation::Product::TaxReturn::Document.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::Income.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::Payment.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::Transaction.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::GoalTransaction.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::Goal.where(tax_return_id: tax_return.id).destroy_all
      Operation::Product::TaxReturn::Achievement.where(tax_return_id: tax_return.id).destroy_all
      # Operations::Products::TaxReturns::Calculations::RefreshCalculationService.new(tax_return, nil)
      # Operations::Products::TaxReturns::Achievements::RefreshAchievementService.new(tax_return, nil)
      Operation::Product::Date.where(product_id: tax_return.id).destroy_all
    end
  end

  def self.clean_medreturn(tax_filing)
    if Rails.env == "development"
      Operation::Product::TaxFiling::File.where(tax_filing_id: tax_filing.id).destroy_all
      Operation::Product::TaxFiling::Agent.where(tax_filing_id: tax_filing.id).destroy_all
      Operation::Product::TaxFiling::Journey.where(tax_filing_id: tax_filing.id).destroy_all
      # Operation::Product::TaxFiling::Ticket.where(tax_filing_id: tax_filing.id).destroy_all
      Operation::Message::Room.where(obj_id: tax_filing.id, obj_type: tax_filing.class.name).each do |room|
        Operation::Message::Entity.where(room_id: room.id).destroy_all
      end
      Operation::Product::Date.where(product_id: tax_filing.id).destroy_all
    end
  end

  def self.clean_all_products(product_name)
    if Rails.env == "development"
      # products = entity.where(name: product_name)
      # products.each do |product|
      #   if product.name == "medbooking" && product.kind == "practice"
      #     clean_medbooking(product)
      #   elsif product.name == "medreturn" && product.kind == "receivement"
      #     clean_medreturn(product)
      #   end
      # end
    end
  end
  
  

  private

  def self.entity
    "Operation::Product::Entity".constantize
  end

  def self.mapper
    "Operations::Products::EntityMapper".constantize
  end

  ENUM_NAME = {
                "medpj" => "Med PJ",
                "medpf" => "Med PF",
                "medreturn" => "Planner Anual",
                "medfiling" => "Declaração de Ajuste Anual",
                "medbooking" => "Livro-Caixa Consultório",
                "medclinic" => "PJ-Medica",
                "medfat" => "Med Faturamento",
                "medseg" => "Med Seguros",
                "medfin" => "Med Finanças",
                "medpayroll" => "Folha de Pagamento",
              }
    
  PRODUCT_DATE = {
                    "medreturn" => "Competência",
                    "medfiling" => "Exercício",
                    "medbooking" => "Competência",
                    "medclinic" => "Competência",
                    "medfat" => "Competência",
                    "medseg" => "Competência",
                    "medfin" => "Competência",
                  }
  
  PRODUCT_PATH = {
                "medpj" => {"receivement" => "pj-medica", "practice" =>"pj-medica"},
                "medpf" => {"receivement" => "declaracao-imposto-de-renda", "practice" =>"livro-caixa"},
                "medfat" => {"receivement" => "recebimentos", "practice" =>"faturamento-medico"},
                "medreturn" => {"receivement" => "planner-anual"},
                "medbooking" => {"practice" => "livro-caixa"},
                "medclinic" => {"practice" => "pj-medica"},
                "medfiling" => {"receivement" => "declaracao-de-ajuste"},
              }

  CONFIG_PATH = {
                "medpj" => {"receivement" =>"pj-medica", "practice" =>"pj-medica"},
                "medpf" => {"receivement" =>"declaracao-imposto-de-renda", "practice" =>"livro-caixa"},
                "medfat" => "/a/configuracoes-recebimentos",
              }
              

  ENUM_KIND = {
                "receivement" => "Recebimento",
                "practice" => "Consultório",
              }

  ENUM_STATUS = {
                  "going" => "Ativo",
                  "onboard" => "Onboard",
                  "renewal" => "Renovação",
                  "blocked" => "Bloqueado",
                  "cancel" => "Cancelado",
                }

  CONTROLLER_PATH = {
                      "receivements" => {"name" =>"medfat", "kind" =>"receivement"},
                    }
  

end