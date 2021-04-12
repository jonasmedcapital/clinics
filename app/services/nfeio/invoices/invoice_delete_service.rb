class Nfeio::Invoices::InvoiceDeleteService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from delete join table receipt and nfe_invoice form
  def initialize nfe_invoice
    @nfe_invoice = nfe_invoice
    # @nfe_company = @clinic.nfe_company
    
    response = delete
  end

  def delete
    # initialize request data
    nfe_company_id = "5fc0e90bd942771f14f9a8fd" # @nfe_company.nfe_company_id
    nfe_invoice_id = @nfe_invoice.nfe_invoice_id # @nfe_invoice.nfe_invoice_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/serviceinvoices/#{nfe_invoice_id}" 
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
    invoice_hash = JSON.parse(response.body)

    if ["200", "201", "202"].include? response.code
      @nfe_invoice.update(active: false)
    else
      puts "ERROR AO CANCELAR NF"
    end

  end
end

#   #### invoice hash looks like #### 
#   { something here }

