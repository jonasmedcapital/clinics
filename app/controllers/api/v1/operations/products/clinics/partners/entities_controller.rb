module API
  module V1
    module Operations
      module Products
        module Clinics
          module Partners
            class EntitiesController < ApplicationController
              
              def create
                partner = ::Operations::Products::Clinics::Partners::Entities::Create.new(params)
                render :json => {:save => partner.save, :data => partner.data, :status => partner.status, :type => partner.type, :message => partner.message}.as_json
              end

              def update
                partner = ::Operations::Products::Clinics::Partners::Entities::Update.new(params)
                render :json => {:save => partner.save, :data => partner.data, :status => partner.status, :type => partner.type, :message => partner.message}.as_json
              end
              
              def read
                partner = ::Operations::Products::Clinics::Partners::Entities::Read.new(params)
                render :json => {:data => partner.data, :process => partner.process?, :type => partner.type, :message => partner.message}.as_json
              end

              def list
                list = ::Operations::Products::Clinics::Partners::Entities::List.new(params)
                render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
              end
            end
          end
        end
      end
    end
  end
end