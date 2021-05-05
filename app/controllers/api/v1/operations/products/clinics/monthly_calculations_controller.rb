module API
  module V1
    module Operations
      module Products
        module Clinics
          class MonthlyCalculationsController < ApplicationController
            
            def create
              calculation = ::Operations::Products::Clinics::MonthlyCalculations::Create.new(params)
              render :json => {:save => calculation.save, :data => calculation.data, :status => calculation.status, :type => calculation.type, :message => calculation.message}.as_json
            end

            def update
              calculation = ::Operations::Products::Clinics::MonthlyCalculations::Update.new(params)
              render :json => {:save => calculation.save, :data => calculation.data, :status => calculation.status, :type => calculation.type, :message => calculation.message}.as_json
            end
            
            def read
              calculation = ::Operations::Products::Clinics::MonthlyCalculations::Read.new(params)
              render :json => {:data => calculation.data, :process => calculation.process?, :type => calculation.type, :message => calculation.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::MonthlyCalculations::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end