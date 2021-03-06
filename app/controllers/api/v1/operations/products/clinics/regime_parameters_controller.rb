module API
  module V1
    module Operations
      module Products
        module Clinics
          class RegimeParametersController < ApplicationController
            
            def create
              regime_parameter = ::Operations::Products::Clinics::RegimeParameters::Create.new(params)
              render :json => {:save => regime_parameter.save, :data => regime_parameter.data, :status => regime_parameter.status, :type => regime_parameter.type, :message => regime_parameter.message}.as_json
            end

            def update
              regime_parameter = ::Operations::Products::Clinics::RegimeParameters::Update.new(params)
              render :json => {:save => regime_parameter.save, :data => regime_parameter.data, :status => regime_parameter.status, :type => regime_parameter.type, :message => regime_parameter.message}.as_json
            end
            
            def read
              regime_parameter = ::Operations::Products::Clinics::RegimeParameters::Read.new(params)
              render :json => {:data => regime_parameter.data, :process => regime_parameter.process?, :type => regime_parameter.type, :message => regime_parameter.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::RegimeParameters::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end