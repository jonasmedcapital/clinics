module API
  module V1
    module Operations
      module Products
        module Clinics
          class TakersController < ApplicationController
            
            def create
              taker = ::Operations::Products::Clinics::Takers::Create.new(params)
              render :json => {:save => taker.save, :data => taker.data, :status => taker.status, :type => taker.type, :message => taker.message}.as_json
            end

            def update
              taker = ::Operations::Products::Clinics::Takers::Update.new(params)
              render :json => {:save => taker.save, :data => taker.data, :status => taker.status, :type => taker.type, :message => taker.message}.as_json
            end
            
            def read
              taker = ::Operations::Products::Clinics::Takers::Read.new(params)
              render :json => {:data => taker.data, :process => taker.process?, :type => taker.type, :message => taker.message}.as_json
            end

            def list
              list = ::Operations::Products::Clinics::Takers::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
          end
        end
      end
    end
  end
end