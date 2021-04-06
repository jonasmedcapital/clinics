module API
  module V1
    module Operations
      module Products
        module Clinics
          class PartnersController < ApplicationController
            
            def create
              partner = ::Operations::Products::Clinics::Partners::Create.new(params)
              render :json => {:save => partner.save, :data => partner.data, :status => partner.status, :type => partner.type, :message => partner.message}.as_json
            end

            def update
              partner = ::Operations::Products::Clinics::Partners::Update.new(params)
              render :json => {:save => partner.save, :data => partner.data, :status => partner.status, :type => partner.type, :message => partner.message}.as_json
            end
            
            def read
              partner = ::Operations::Products::Clinics::Partners::Read.new(params)
              render :json => {:data => partner.data, :process => partner.process?, :type => partner.type, :message => partner.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::Partners::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end