class Nfeio::Companies::Entities::CompanyShowService

  require 'net/http'
  require 'uri'
  require 'json'

  # comes from some service that needs to look one company inside nfeio
  def initialize # nfe_company
    # @nfe_company = nfe_company
    
    response = show
  end

  def show
    # initialize request data
    nfe_company_id = "5fc0e90bd942771f14f9a8fdsss" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["accept"] = content_type

    # response
    response = http.request(request)

    # manipulate response
    if ["200", "201", "202"].include? response.code
      puts JSON.parse(response.body)
    else
      puts "ERROR AO MOSTRAR A EMPRESA"
      puts "ESSA EMPRESA NAO EXISTE"
      puts "PROBLEMAS NA API DO NFEIO"
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