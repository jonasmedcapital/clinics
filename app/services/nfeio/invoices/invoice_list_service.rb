class Nfeio::Invoices::InvoiceListService

  require 'net/http'
  require 'uri'
  require 'json'

  # comes from some service that needs to look list of invoices inside nfeio
  def initialize # nfe_company
    # @nfe_company = nfe_company
    
    response = list
  end

  def list
    # initialize request data 
    nfe_company_id = "5fc0e90bd942771f14f9a8fd" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/serviceinvoices"
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
    invoices_hash = JSON.parse(response.body)
    
    # manipulate response
    if ["200", "201", "202"].include? response.code
      invoices_hash = JSON.parse(response.body)

      puts invoices_hash
    else
      puts "ERROR AO LISTAR NFs"
    end    
  end
  
end


#   #### invoices hash looks like #### 
#   { }