module API
  module V1
    module Operations
      module Products
        module Clinics
          class InvoicesController < ApplicationController
            
            def create
              invoice = ::Operations::Products::Clinics::Invoices::Create.new(params)
              render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
            end

            def update
              invoice = ::Operations::Products::Clinics::Invoices::Update.new(params)
              render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
            end
            
            def read
              invoice = ::Operations::Products::Clinics::Invoices::Read.new(params)
              render :json => {:data => invoice.data, :process => invoice.process?, :type => invoice.type, :message => invoice.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::Invoices::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end