class Nfeio::Webhooks::WebhooksListService

  require 'net/http'
  require 'uri'
  require 'json'

  # comes from some service that needs to look list of webhooks inside nfeio
  def initialize

    response = list
  end
  
  def list
    # initialize request data 
    url = "https://api.nfe.io/v1/hooks"
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
    webhooks_hash =  JSON.parse(response.body)
    
  end
end

#   #### webhook hash looks like #### 
#   { }