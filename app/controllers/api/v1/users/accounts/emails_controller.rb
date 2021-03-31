module API
  module V1
    module Users
      module Accounts
        class EmailsController < ApplicationController

          def create
            email = ::Users::Accounts::Emails::Create.new(params)
            render :json => {:save => email.save, :status => email.status, :process => email.process?, :type => email.type, :message => email.message, :data => email.data}.as_json
          end

          def update
            email = ::Users::Accounts::Emails::Update.new(params)
            render :json => {:save => email.save, :status => email.status, :process => email.process?, :type => email.type, :message => email.message, :data => email.data}.as_json
          end
          
          def read
            email = ::Users::Accounts::Emails::Read.new(params)
            render :json => {:status => email.status, :process => email.process?, :type => email.type, :message => email.message, :data => email.data}.as_json
          end

          def list
            list = ::Users::Accounts::Emails::List.new(params)
            render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
          end

        end
      end
    end
  end
end