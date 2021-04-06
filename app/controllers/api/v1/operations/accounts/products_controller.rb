module API
  module V1
    module Operations
      module Accounts
        class ProductsController < ApplicationController
          
          def read
            product = ::Operations::Accounts::Products::Read.new(params)
            render :json => {:data => product.data, :status => product.status, :type => product.type, :message => product.message, :process => product.process?}.as_json
          end

          def read_with_calculations
            product = ::Operations::Accounts::Products::ReadWithCalculations.new(params)
            render :json => {:data => product.data, :status => product.status, :type => product.type, :message => product.message, :process => product.process?}.as_json
          end

          def read_with_account
            product = ::Operations::Accounts::Products::ReadWithAccount.new(params)
            render :json => {:data => product.data, :status => product.status, :type => product.type, :message => product.message, :process => product.process?}.as_json
          end

          def list
            list = ::Operations::Accounts::Products::List.new(params)
            render :json => {:status => list.status, :type => list.type, :message => list.message, :data => list.data}.as_json
          end

          def list_with_accounts
            list = ::Operations::Accounts::Products::ListWithAccounts.new(params)
            render :json => {:status => list.status, :type => list.type, :message => list.message, :data => list.data}.as_json
          end

        end
      end
    end
  end
end