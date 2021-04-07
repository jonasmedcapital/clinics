class Nfeio::Companies::Entities::CompanyCreateService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from product clinic create
  def initialize
    # @clinic = clinic
    # @company = clinic.company

    response = create
  end

  def create
    # initialize request data
    url = "https://api.nfe.io/v1/companies"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"
    
    # initialize request json 
    company_params = {
      name: "EMPRESA DE TESTE CERTIFICADO", # @company.name
      tradeName: "EMPRESA DE TESTE CERTIFICADO", # @company.trade_name
      federalTaxNumber: "74263783000132", # @company.federal_tax_number
      address: {
        postalCode: "31270-190",
        street: "Rua Vital Brasil",
        number: "429",
        additionalInformation: "201",
        district: "Liberdade",
        city: {
            code: "3106200",
            name: "Belo Horizonte"
        },
        state: "MG"
      },
      taxRegime: "MicroempreendedorIndividual",
      specialTaxRegime: "Nenhum",
      legalNature: "Empresario",
      economicActivities: [
        
      ],
      municipalTaxNumber: "12409170015",
      rpsSerialNumber: "IO",
      rpsNumber: 1,
      issRate: 0.0,
      environment: "Development",
      fiscalStatus: "Pending",
      certificate: {
        status: "Pending"
      },
      createdOn: "2020-11-27T11:54:51.1384445+00:00",
      modifiedOn: "2020-11-27T11:54:51.5049311+00:00"
    }

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.body = company_params.to_json

    # response
    response = http.request(request)

    # manipulate response 
    if ["200", "201", "202"].include? response.code
      company_hash = JSON.parse(response.body)

      # create nfe_company
      nfe_company = Operation::Product::Clinic::Nfe::Company::Entity.new
      nfe_company.clinic_id = 1
      nfe_company.company_id = 1
      nfe_company.nfe_company_id = company_hash["companies"]["id"]
      nfe_company.save!
    else
      puts "ERROR AO CRIAR EMPRESA"
    end

  end

end

    #### company hash looks like #### 
    #   {
    #     "id""=>""6026ca41003cad1fdc9eda43",
    #     "name""=>""TESTANDO",
    #     "tradeName""=>""FT TECHNOLOGY",
    #     "federalTaxNumber"=>5906139000112,
    #     "address""=>"{
    #        "postalCode""=>""31270-190",
    #        "street""=>""Rua Vital Brasil",
    #        "number""=>""429",
    #        "additionalInformation""=>""201",
    #        "district""=>""Liberdade",
    #        "city""=>"{
    #           "code""=>""3106200",
    #           "name""=>""Belo Horizonte"
    #        },
    #        "state""=>""MG"
    #     },
    #     "taxRegime""=>""MicroempreendedorIndividual",
    #     "specialTaxRegime""=>""Nenhum",
    #     "legalNature""=>""Empresario",
    #     "economicActivities""=>"[
          
    #     ],
    #     "municipalTaxNumber""=>""12409170015",
    #     "rpsSerialNumber""=>""IO",
    #     "rpsNumber"=>1,
    #     "issRate"=>0.0,
    #     "environment""=>""Development",
    #     "fiscalStatus""=>""Pending",
    #     "certificate""=>"{
    #        "status""=>""Pending"
    #     },
    #     "createdOn""=>""2021-02-12T18:34:41.2226536+00:00",
    #     "modifiedOn""=>""2021-02-12T18:34:41.2226536+00:00"
    #  }