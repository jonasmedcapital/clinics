module API
  module V1
    module Operations
      module Products
        module Clinics
          class YearlyCalculationsController < ApplicationController
            
            def create
              calculation = ::Operations::Products::Clinics::YearlyCalculations::Create.new(params)
              render :json => {:save => calculation.save, :data => calculation.data, :status => calculation.status, :type => calculation.type, :message => calculation.message}.as_json
            end

            def update
              calculation = ::Operations::Products::Clinics::YearlyCalculations::Update.new(params)
              render :json => {:save => calculation.save, :data => calculation.data, :status => calculation.status, :type => calculation.type, :message => calculation.message}.as_json
            end
            
            def read
              calculation = ::Operations::Products::Clinics::YearlyCalculations::Read.new(params)
              render :json => {:data => calculation.data, :process => calculation.process?, :type => calculation.type, :message => calculation.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::YearlyCalculations::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end