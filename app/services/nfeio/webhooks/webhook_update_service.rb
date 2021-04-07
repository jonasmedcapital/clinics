class Nfeio::Webhooks::WebhookUpdateService
  require 'net/http'
  require 'uri'
  require 'json'

  # comes from update webhook forms
  def initialize webhook
    @nfe_webhook = @nfe_account.nfe_webhook
    @webhook = webhook
    
    response = update
  end

  def update
    # initialize request data
    nfe_webhook_id = "5fc0e90bd942771f14f9a8fd" # @nfe_webhook.nfe_webhook_id
    url = "https://api.nfe.io/v1/hooks/#{nfe_webhook_id}"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"

    # initialize request json 
    webhook_params = {
      key: @webhook.values # create this json
    }
    
    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Put.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.body = webhook_params.to_json

    # response
    response = http.request(request)

    # manipulate response
    webhook_hash = JSON.parse(response.body)
    
  end  
end

#   #### webhook hash looks like #### 
#   { }