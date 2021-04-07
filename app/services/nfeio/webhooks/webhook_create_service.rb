class Nfeio::Webhooks::WebhookCreateService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from webhook create form
  def initialize webhook
    @webhook = webhook
    response = create
  end

  def create
    # initialize request data
    url = "https://api.nfe.io/v1/hooks"
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
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.body = webhook_params.to_json

    # response
    response = http.request(request)

    # manipulate data
    webhook_hash = JSON.parse(response.body)

    # implement:
    # create webhook with the response body ? 
    # create webhook_events with the response body ? 
  end
end

#   #### invoice hash equals #### 
#   { something here }