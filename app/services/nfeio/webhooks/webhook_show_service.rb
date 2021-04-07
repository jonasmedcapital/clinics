class Nfeio::Webhooks::WebhookShowService

  require 'net/http'
  require 'uri'
  require 'json'

  # comes from some service that needs to look one webhook inside nfeio
  def initialize receipt, clinic
    @nfe_webhook = @nfe_account.nfe_webhook
    @receipt = receipt
    
    response = show
  end

  def show
    # initialize request data
    nfe_webhook_id = "0000" # @nfe_webhook.nfe_webhook_id
    url = "https://api.nfe.io/v1/hooks/#{nfe_webhook_id}"
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
    webhooks_hash = JSON.parse(response.body)
    
  end
end

#### company hash looks like #### 
#   { }