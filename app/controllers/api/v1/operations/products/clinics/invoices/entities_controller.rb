module API
  module V1
    module Operations
      module Products
        module Clinics
          module Invoices
            class EntitiesController < ApplicationController
              
              def create
                invoice = ::Operations::Products::Clinics::Invoices::Entities::Create.new(params)
                render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
              end

              def update
                invoice = ::Operations::Products::Clinics::Invoices::Entities::Update.new(params)
                render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
              end
              
              def read
                invoice = ::Operations::Products::Clinics::Invoices::Entities::Read.new(params)
                render :json => {:data => invoice.data, :process => invoice.process?, :type => invoice.type, :message => invoice.message}.as_json
              end

              def list
                list = ::Operations::Products::Clinics::Invoices::Entities::List.new(params)
                render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
              end
            end
          end
        end
      end
    end
  end
end