module API
  module V1
    module Operations
      module Products
        module Clinics
          module Cnaes
            class EntitiesController < ApplicationController
              
              def create
                cnae = ::Operations::Products::Clinics::Cnaes::Entities::Create.new(params)
                render :json => {:save => cnae.save, :data => cnae.data, :status => cnae.status, :type => cnae.type, :message => cnae.message}.as_json
              end

              def update
                cnae = ::Operations::Products::Clinics::Cnaes::Entities::Update.new(params)
                render :json => {:save => cnae.save, :data => cnae.data, :status => cnae.status, :type => cnae.type, :message => cnae.message}.as_json
              end
              
              def read
                cnae = ::Operations::Products::Clinics::Cnaes::Entities::Read.new(params)
                render :json => {:data => cnae.data, :process => cnae.process?, :type => cnae.type, :message => cnae.message}.as_json
              end

              def list
                list = ::Operations::Products::Clinics::Cnaes::Entities::List.new(params)
                render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
              end
            end
          end
        end
      end
    end
  end
end