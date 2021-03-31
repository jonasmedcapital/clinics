module API
  module V1
    module Users
      module Accounts
        class AddressesController < ApplicationController

          def create
            address = ::Users::Accounts::Addresses::Create.new(params)
            render :json => {:save => address.save, :status => address.status, :process => address.process?, :type => address.type, :message => address.message, :data => address.data}.as_json
          end

          def update
            address = ::Users::Accounts::Addresses::Update.new(params)
            render :json => {:save => address.save, :status => address.status, :process => address.process?, :type => address.type, :message => address.message, :data => address.data}.as_json
          end
          
          def read
            address = ::Users::Accounts::Addresses::Read.new(params)
            render :json => {:status => address.status, :process => address.process?, :type => address.type, :message => address.message, :data => address.data}.as_json
          end

          def list
            list = ::Users::Accounts::Addresses::List.new(params)
            render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
          end

          def cities_by_state
            list = ::Users::Accounts::Addresses::CitiesByState.new(params)
            render :json => {:process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
          end

        end
      end
    end
  end
end