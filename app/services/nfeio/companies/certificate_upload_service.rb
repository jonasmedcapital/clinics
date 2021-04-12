class Nfeio::Companies::CertificateUploadService

  require 'net/http'
  require 'uri'
  require 'json'
  
  # comes from certificate upload
  def initialize nfe_company #, license
    @nfe_company = nfe_company
    # @license = license
    response = upload
  end

  def upload
    # initialize request data
    # need to set file and password correctly
    file = File.open("/home/jonas/Downloads/JONAS FERREIRA DA TRINDADE 1304306763038009468000110.pfx")
    password = "medcapital@2021"
    nfe_company_id = "603420a91f8db412f4943a3a" # @nfe_company.nfe_company_id
    url = "https://api.nfe.io/v1/companies/#{nfe_company_id}/certificate"
    api_key = ENV["API_KEY"] # [ENV]
    user_agent = "NFe.io Ruby Client v0.3.2"
    content_type = "multipart/form-data"
    
    # initialize request json
    certificate_params = { 
      'password' => password, 
      'file' => file 
    }

    # request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = api_key 
    request["user_agent"] = user_agent
    request["Content-Type"] = content_type
    request.set_form(certificate_params, content_type)

    # response
    response = http.request(request)    

    # manipulate response
    if ["200", "201", "202"].include? response.code
      certificate_hash = JSON.parse(response.to_json)
    else
      puts "ERRO NA API DO NFEIO,
            ERRO AO SUBIR ARQUIVO"
    end   
  end
  
  end

#   #### certificate hash looks like #### 
#   { }
