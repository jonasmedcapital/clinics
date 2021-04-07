class Nfeio::Entities::InvoiceDownloadPdfService

  require 'net/http'
  require 'open-uri'
  require 'uri'
  require 'json'

  # comes from some service that needs to download invoices from nfeio
  def initialize nfe_invoice
    @nfe_invoice = nfe_invoice
    @receipt = @nfe_invoice.receipt
    @nfe_company = @nfe_invoice.clinic.nfe_company
        
    response = download
  end

  def download
    # initialize request data 
    nfe_company_id = @nfe_company.nfe_company_id
    nfe_invoice_id = @nfe_invoice.nfe_invoice_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/serviceinvoices/#{nfe_invoice_id}/pdf"
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
    if response.code == "302" && JSON.parse(response.to_json)["location"].present?
      download_link = JSON.parse(response.to_json)["location"][0]
      url = URI.parse(download_link)
      filename = File.basename(url.path)
      file = URI.open(download_link)
      
      # attach file active storage
      @nfe_invoice.pdf.attach(io: file, filename: filename)
      @nfe_invoice.save!
    else
      # Job
      AttachPdfJob.set(wait: 30.seconds).perform_later @nfe_invoice
    end
  end
end  

#   #### download hash looks like #### 
#   { }