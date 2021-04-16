module API
  module V1
    module Nfe
      class CertificatesController < ApplicationController

        def create
          certificate = ::Nfe::Certificates::Create.new(params)
          render :json => {:save => certificate.save, :data => certificate.data, :status => certificate.status, :type => certificate.type, :message => certificate.message}.as_json              
        end

        def save_upload
          certificate = ::Nfe::Certificates::SaveUpload.new(params)
          render :json => {:save => certificate.save, :data => certificate.data, :status => certificate.status, :type => certificate.type, :message => certificate.message}.as_json
        end

        def update
          certificate = ::Nfe::Certificates::Update.new(params)
          render :json => {:save => certificate.save, :data => certificate.data, :status => certificate.status, :type => certificate.type, :message => certificate.message}.as_json
        end
        
        def read
          certificate = ::Nfe::Certificates::Read.new(params)
          render :json => {:data => certificate.data, :status => certificate.status, :process => certificate.process?, :type => certificate.type, :message => certificate.message}.as_json
        end

        def list
          list = ::Nfe::Certificates::List.new(params)
          render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
        end

      end
    end
  end
end