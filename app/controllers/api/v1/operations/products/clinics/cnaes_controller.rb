module API
  module V1
    module Operations
      module Products
        module Clinics
          class CnaesController < ApplicationController
            
            def create
              cnae = ::Operations::Products::Clinics::Cnaes::Create.new(params)
              render :json => {:save => cnae.save, :data => cnae.data, :status => cnae.status, :type => cnae.type, :message => cnae.message}.as_json
            end

            def update
              cnae = ::Operations::Products::Clinics::Cnaes::Update.new(params)
              render :json => {:save => cnae.save, :data => cnae.data, :status => cnae.status, :type => cnae.type, :message => cnae.message}.as_json
            end
            
            def read
              cnae = ::Operations::Products::Clinics::Cnaes::Read.new(params)
              render :json => {:data => cnae.data, :process => cnae.process?, :type => cnae.type, :message => cnae.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::Cnaes::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end

            def list_ctiss
              list = ::Operations::Products::Clinics::Cnaes::ListCtiss.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
            
          end
        end
      end
    end
  end
end