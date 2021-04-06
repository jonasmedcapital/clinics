module API
  module V1
    module Operations
      module Products
        module Clinics
          module Receipts
            class EntitiesController < ApplicationController
              
              def create
                receipt = ::Operations::Products::Clinics::Receipts::Entities::Create.new(params)
                render :json => {:save => receipt.save, :data => receipt.data, :status => receipt.status, :type => receipt.type, :message => receipt.message}.as_json
              end

              def update
                receipt = ::Operations::Products::Clinics::Receipts::Entities::Update.new(params)
                render :json => {:save => receipt.save, :data => receipt.data, :status => receipt.status, :type => receipt.type, :message => receipt.message}.as_json
              end
              
              def read
                receipt = ::Operations::Products::Clinics::Receipts::Entities::Read.new(params)
                render :json => {:data => receipt.data, :process => receipt.process?, :type => receipt.type, :message => receipt.message}.as_json
              end

              def list
                list = ::Operations::Products::Clinics::Receipts::Entities::List.new(params)
                render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
              end
            end
          end
        end
      end
    end
  end
end