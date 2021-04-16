class Nfeio::Invoices::InvoiceCreateService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from receipt create form
  def initialize invoice
    @nfe_invoice = invoice
    @receipt = @nfe_invoice.receipt
    @nfe_company = @nfe_invoice.clinic.nfe_company

    response = create
  end

  def create
    # initialize request data
    nfe_company_id = @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/serviceinvoices"
    api_key = ENV["API_KEY"]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"

    # initialize request json 
    get_receipt

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.body = @invoice_params.to_json

    # response

    response = http.request(request)

    if ["200", "201", "202"].include? response.code
      # manipulate response
      invoice_hash = JSON.parse(response.body)

      # create join table with receipt and nfe_invoice
      @nfe_invoice.nfe_invoice_id = invoice_hash["id"]
      @nfe_invoice.save!
      
      AttachPdfJob.set(wait: 30.seconds).perform_later @nfe_invoice
      AttachXmlJob.set(wait: 40.seconds).perform_later @nfe_invoice
    else
      # error
      puts "===========================ERRO AO CRIAR NOTA FISCAL======================="
    end
  end

  def get_receipt
    
    if @receipt.taker_type == "User::Account::Entity"

      @invoice_params = {
        borrower: {
          type: "NaturalPerson",
          name: @receipt.taker_name,
          federalTaxNumber: @receipt.taker_federal_tax_number,
          email: "jonas.trindade@medcapital.com.br",
          address: {
            country: @receipt.taker_country,
            postalCode: @receipt.taker_postal_code,
            street: @receipt.taker_street,
            number: @receipt.taker_number,
            additionalInformation: @receipt.taker_complement,
            district: @receipt.taker_district,
            city: {
              code: @receipt.taker_city_code,
              name: @receipt.taker_city_name
            },
            state: @receipt.taker_state
          }
        },
        cityServiceCode: @receipt.city_service_code,
        federalServiceCode: @receipt.federal_service_code,
        cnaeCode: @receipt.cnae_code,
        description: @receipt.description,
        servicesAmount: @receipt.services_amount.to_f,
        issuedOn: @receipt.issued_on.to_time,
        taxationType: @receipt.taxation_type.camelize,
        issRate: @receipt.iss_rate.to_f,
        issTaxAmount: @receipt.iss_tax_amount.to_f,
        deductionsAmount: @receipt.deductions_amount.to_f,
        discountUnconditionedAmount: @receipt.unconditioned_amount.to_f,
        discountConditionedAmount: @receipt.conditioned_amount.to_f,
        irAmountWithheld: @receipt.ir_amount_withheld.to_f,
        pisAmountWithheld: @receipt.pis_amount_withheld.to_f,
        cofinsAmountWithheld: @receipt.cofins_amount_withheld.to_f,
        csllAmountWithheld: @receipt.csll_amount_withheld.to_f,
        inssAmountWithheld: @receipt.inss_amount_withheld.to_f,
        issAmountWithheld: @receipt.iss_amount_withheld.to_f,
        othersAmountWithheld: @receipt.others_amount_withheld.to_f,
        location: {
          state: @receipt.service_state,
          city: {
            code: @receipt.service_city_code,
            name: @receipt.service_city_name
          }
        }
      }

    elsif @receipt.taker_type == "User::Company::Entity"

      @invoice_params = {
        borrower: {
          type: "LegalEntity",
          name: @receipt.taker_name,
          federalTaxNumber: @receipt.taker_federal_tax_number,
          municipalTaxNumber: @receipt.taker_municipal_tax_number,
          email: "jonas.trindade@medcapital.com.br",
          address: {
            country: @receipt.taker_country,
            postalCode: @receipt.taker_postal_code,
            street: @receipt.taker_street,
            number: @receipt.taker_number,
            additionalInformation: @receipt.taker_complement,
            district: @receipt.taker_district,
            city: {
              code: @receipt.taker_city_code,
              name: @receipt.taker_city_name
            },
            state: @receipt.taker_state
          }
        },
        cityServiceCode: @receipt.city_service_code,
        federalServiceCode: @receipt.federal_service_code,
        cnaeCode: @receipt.cnae_code,
        description: @receipt.description,
        servicesAmount: @receipt.services_amount.to_f,
        issuedOn: @receipt.issued_on.to_time,
        taxationType: @receipt.taxation_type.camelize,
        issRate: @receipt.iss_rate.to_f,
        issTaxAmount: @receipt.iss_tax_amount.to_f,
        deductionsAmount: @receipt.deductions_amount.to_f,
        discountUnconditionedAmount: @receipt.unconditioned_amount.to_f,
        discountConditionedAmount: @receipt.conditioned_amount.to_f,
        irAmountWithheld: @receipt.ir_amount_withheld.to_f,
        pisAmountWithheld: @receipt.pis_amount_withheld.to_f,
        cofinsAmountWithheld: @receipt.cofins_amount_withheld.to_f,
        csllAmountWithheld: @receipt.csll_amount_withheld.to_f,
        inssAmountWithheld: @receipt.inss_amount_withheld.to_f,
        issAmountWithheld: @receipt.iss_amount_withheld.to_f,
        othersAmountWithheld: @receipt.others_amount_withheld.to_f,
        location: {
          state: @receipt.service_state,
          city: {
            code: @receipt.service_city_code,
            name: @receipt.service_city_name
          }
        }
      }
    else
      puts "======================================JSON DA NF QUEBRADO================================================="
    end
  end

end


# invoice params
# {
#   borrower: {
#     type: "NaturalPerson",
#     name: "Jonas Ferreira da Trindade",
#     federalTaxNumber: 13043067630,
#     municipalTaxNumber: "string",
#     email: "jonastrinda@gmail.com",
#     address: {
#       country: "BRA",
#       postalCode: "30180121",
#       street: "Rua Alvarenga Peixoto",
#       number: "1249",
#       additionalInformation: "202",
#       district: "Santo Agostinho",
#       city: {
#         code: "3106200",
#         name: "Belo Horizonte"
#       },
#       state: "MG"
#     }
#   },
#   cityServiceCode: "040100188",
#   cnaeCode: "871150100",
#   description: "Consulta Médica ao paciente Jonas Ferreira da Trindade, CRM do DR 123456",
#   servicesAmount: 500.0,
#   issuedOn: "2021-02-19T13:37:17.256Z",
#   taxationType: "WithinCity",
#   location: {
#     state: "MG",
#     city: {
#       code: "3106200",
#       name: "Belo Horizonte"
#     }
#   }
# }

# invoice hash looks like 
# {
#   "id"=>"602fc70d1f8db412f4f5e641",
#   "environment"=>"Development",
#   "flowStatus"=>"WaitingCalculateTaxes",
#   "provider"=>{
#      "tradeName"=>"FT TECHNOLOGY",
#      "taxRegime"=>"SimplesNacional",
#      "specialTaxRegime"=>"Nenhum",
#      "legalNature"=>"EireliNaturezaSimples",
#      "economicActivities"=>[
        
#      ],
#      "municipalTaxNumber"=>"12409170015",
#      "issRate"=>0.0,
#      "parentId"=>"5f5a698253e1ec5b54e58457",
#      "id"=>"5fc0e90bd942771f14f9a8fd",
#      "name"=>"JONAS FERREIRA DA TRINDADE 13043067630",
#      "federalTaxNumber"=>38009468000110,
#      "address"=>{
#         "postalCode"=>"31270-190",
#         "street"=>"Rua Vital Brasil",
#         "number"=>"429",
#         "additionalInformation"=>"201",
#         "district"=>"Liberdade",
#         "city"=>{
#            "code"=>"3106200",
#            "name"=>"Belo Horizonte"
#         },
#         "state"=>"MG"
#      },
#      "status"=>"Active",
#      "type"=>"LegalPerson, Company",
#      "createdOn"=>"2020-11-27T11:54:51.1384445+00:00",
#      "modifiedOn"=>"2021-02-19T13:35:59.300756+00:00"
#   },
#   "borrower"=>{
#      "id"=>"602fc70d1f8db412f4f5e643",
#      "name"=>"Jonas Ferreira da Trindade",
#      "federalTaxNumber"=>13043067630,
#      "email"=>"jonastrinda@gmail.com",
#      "address"=>{
#         "country"=>"BRA",
#         "postalCode"=>"30180121",
#         "street"=>"Rua Alvarenga Peixoto",
#         "number"=>"1249",
#         "additionalInformation"=>"202",
#         "district"=>"Santo Agostinho",
#         "city"=>{
#            "code"=>"3106200",
#            "name"=>"Belo Horizonte"
#         },
#         "state"=>"MG"
#      },
#      "status"=>"Active",
#      "type"=>"NaturalPerson",
#      "createdOn"=>"2021-02-19T14:11:25.7521505+00:00"
#   },
#   "batchNumber"=>0,
#   "number"=>0,
#   "status"=>"Created",
#   "rpsType"=>"Rps",
#   "rpsStatus"=>"Normal",
#   "taxationType"=>"WithinCity",
#   "issuedOn"=>"2021-02-19T10:37:17.256-03:00",
#   "rpsSerialNumber"=>"IO",
#   "rpsNumber"=>0,
#   "cityServiceCode"=>"040100188",
#   "description"=>"Consulta Médica ao paciente Jonas Ferreira da Trindade, CRM do DR 123456",
#   "servicesAmount"=>500.0,
#   "deductionsAmount"=>0.0,
#   "discountUnconditionedAmount"=>0.0,
#   "discountConditionedAmount"=>0.0,
#   "baseTaxAmount"=>500.0,
#   "issRate"=>0.0,
#   "issTaxAmount"=>0.0,
#   "irAmountWithheld"=>0.0,
#   "pisAmountWithheld"=>0.0,
#   "cofinsAmountWithheld"=>0.0,
#   "csllAmountWithheld"=>0.0,
#   "inssAmountWithheld"=>0.0,
#   "issAmountWithheld"=>0.0,
#   "othersAmountWithheld"=>0.0,
#   "amountWithheld"=>0.0,
#   "amountNet"=>500.0,
#   "location"=>{
#      "state"=>"MG",
#      "city"=>{
#         "code"=>"3106200",
#         "name"=>"Belo Horizonte"
#      }
#   },
#   "approximateTax"=>{
#      "totalRate"=>0.0
#   },
#   "createdOn"=>"2021-02-19T14:11:25.7521505+00:00"
# }



# missing params
# {
#   "federalServiceCode": "string",
#   "rpsSerialNumber": "string",
#   "rpsNumber": 0,
#   "issRate": 0,
#   "issTaxAmount": 0,
#   "deductionsAmount": 0,
#   "discountUnconditionedAmount": 0,
#   "discountConditionedAmount": 0,
#   "irAmountWithheld": 0,
#   "pisAmountWithheld": 0,
#   "cofinsAmountWithheld": 0,
#   "csllAmountWithheld": 0,
#   "inssAmountWithheld": 0,
#   "issAmountWithheld": 0,
#   "othersAmountWithheld": 0,
#   "approximateTax": {
#     "source": "string",
#     "version": "string",
#     "totalRate": 0
#   },
#   "additionalInformation": "string",
# }
