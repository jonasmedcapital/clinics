module API
  module V1
    module Operations
      module Products
        module Clinics
          class DatesController < ApplicationController

            def create
              date = ::Operations::Products::Clinics::Dates::Create.new(params)
              render :json => {:save => date.save, :data => date.data, :status => date.status, :type => date.type, :message => date.message}.as_json
            end

            def update
              date = ::Operations::Products::Clinics::Dates::Update.new(params)
              render :json => {:save => date.save, :data => date.data, :status => date.status, :type => date.type, :message => date.message}.as_json
            end
            
            def read
              date = ::Operations::Products::Clinics::Dates::Read.new(params)
              render :json => {:data => date.data, :status => date.status, :process => date.process?, :type => date.type, :message => date.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::Dates::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end

          end
        end
      end
    end
  end
end