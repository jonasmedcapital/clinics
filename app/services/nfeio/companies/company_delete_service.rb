class Nfeio::Companies::CompanyDeleteService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from delete [company, clinic] form
  def initialize # nfe_company
    # @nfe_company = nfe_company
    
    response = delete
  end
  
  def delete
    # initialize request data
    nfe_company_id = "change thissss" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Delete.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type

    # response
    response = http.request(request)

    # manipulate response 
    if ["200", "201", "202"].include? response.code
      # @nfe_company.company.update(active: false)
    else
      puts "ERROR AO APAGAR EMPRESA"
    end
    
  end
  
end

#### company hash looks like #### 
