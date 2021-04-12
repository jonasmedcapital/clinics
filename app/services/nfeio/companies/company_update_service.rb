class Nfeio::Companies::CompanyUpdateService
  require 'net/http'
  require 'uri'
  require 'json'

  # comes from update company or product clinic forms
  def initialize # clinic
    # @clinic = clinic
    # @company = clinic.company
    # @nfe_company = clinic.nfe_company
    
    response = update
  end

  def update
    # initialize request data
    nfe_company_id = "603420a91f8db412f4943a3a" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"

    # initialize request json 
    company_params = {
      tradeName: "NAME ALLRIGHT"
    }
    
    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Put.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request["Accept"] = "*/*"
    request.body = company_params.to_json

    # response
    response = http.request(request)

    # manipulate response
    if ["200", "201", "202"].include? response.code
      company_hash = JSON.parse(response.body)
      certificate_hash = JSON.parse(response.to_json)
    else
      puts "ERRO NA API DO NFEIO,
            ERRO AO ATUALIZAT EMPRESA"
    end
    
  end  
end

#   #### company hash equals #### 
#   { }