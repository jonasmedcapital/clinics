class Nfeio::Companies::CompanyCreateService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from product clinic create
  def initialize(nfe_company)
    @nfe_company = nfe_company
    @company = nfe_company.company
    @clinic = nfe_company.clinic
    @social_contract = @clinic.clinic_social_contract
    @regime_parameter = @clinic.clinic_regime_parameter
    @tax_regime = Operations::Products::Clinics::RegimeParameterRepository::TAX_REGIME[@regime_parameter.tax_regime]
    @special_tax_regime = Operations::Products::Clinics::RegimeParameterRepository::SPECIAL_TAX_REGIME[@regime_parameter.special_tax_regime]
    @legal_nature = Operations::Products::Clinics::RegimeParameterRepository::LEGAL_NATURE[@regime_parameter.legal_nature]
    @cnae_main = @clinic.clinic_cnaes.where(kind: "main").first
    @address = @company.addresses.where(is_main: true, kind: "commercial").first
    @email = @company.emails.where(is_main: true, kind: "commercial").first
    @phone = @company.phones.where(is_main: true, kind: "commercial").first

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
      name: @company.name,
      tradeName: @company.name,
      federalTaxNumber: @company.cnpj,
      address: {
        postalCode: @address.postal_code,
        street: @address.street,
        number: @address.number,
        additionalInformation: @address.complement,
        district: @address.district,
        city: {
            code: @address.ibge,
            name: @address.city
        },
        state: @address.state
      },
      taxRegime: @tax_regime,
      specialTaxRegime: @special_tax_regime,
      legalNature: @legal_nature,
      economicActivities: [
        {
          type: @cnae_main.kind,
          code: @cnae_main.cnae_code.to_i
        }        
      ],
      municipalTaxNumber: @social_contract.municipal_tax_number,
      issRate: @regime_parameter.iss_rate
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
      @nfe_company.nfe_company_id = company_hash["companies"]["id"]
      @nfe_company.save!
    else
      puts "===============================ERROR AO CRIAR EMPRESA====================================="
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