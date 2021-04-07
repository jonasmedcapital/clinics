class Nfeio::Webhooks::WebhookDeleteService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from delete webhook nfeio form
  def initialize receipt, clinic
    @nfe_webhook = @nfe_account.nfe_webhook
    @receipt = receipt
    
    response = delete
  end

  def delete
    # initialize request data
    nfe_webhooks_id = "000000" # @nfe_webhook.nfe_webhook_id
    url = "https://api.nfe.io/v1/hooks/#{nfe_webhooks_id}"
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
    request.body = invoice_params.to_json

    # response
    response = http.request(request)

    # manipulate response
    webhook_hash = JSON.parse(response.body)

    # implement:
    # response if delete success ? 
    # remove webhook or inactive ?
    # remove events or inactive ?
  end  
end

#   #### webhooks hash looks like #### 
#   { something here }
