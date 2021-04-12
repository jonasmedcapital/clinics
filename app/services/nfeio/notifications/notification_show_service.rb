class Nfeio::Notifications::NotificationShowService

  require 'net/http'
  require 'uri'
  require 'json'

  # comes from some service that needs to look one company inside nfeio
  def initialize # clinic
    # @clinic = clinic
    # @nfe_company = clinic.nfe_company
    
    response = show
  end

  def show
    # initialize request data
    nfe_company_id = "5fc0e90bd942771f14f9a8fd" # @nfe_company.nfe_company_id
    nfe_notification_id = "notification_id"
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/notifications/#{nfe_notification_id}"
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
    notification_hash = JSON.parse(response.body)
  end

end

#### company hash looks like #### 
   