class Nfeio::Companies::Notifications::NotificationEmailService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from product clinic create
  def initialize # clinic
    # @company = clinic.company

    response = create
  end

  def create
    # initialize request data
    nfe_company_id = "5fc0e90bd942771f14f9a8fd" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/notifications/email"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "application/json"
    
    # initialize request json 
    notification_params = {
      
    }

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.body = notification_params.to_json

    # response
    response = http.request(request)

    # manipulate data
    notification_hash = JSON.parse(response.body)

    # create nfe_company
    # nfe_company_notification = Operation::Product::Clinic::Nfe::Company::Entity.new
    # nfe_company_notification.clinic_id = @clinic.id
    # nfe_company_notification.company_id = @company.id
    # nfe_company_notification.nfe_company_id = notification_hash["companies"]["id"]
    # nfe_company_notification.save!

  end

end

    #### company hash looks like #### 
      