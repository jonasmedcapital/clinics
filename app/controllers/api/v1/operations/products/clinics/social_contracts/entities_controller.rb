module API
  module V1
    module Operations
      module Products
        module Clinics
          module SocialContracts
            class EntitiesController < ApplicationController
              
              def create
                social_contract = ::Operations::Products::Clinics::SocialContracts::Entities::Create.new(params)
                render :json => {:save => social_contract.save, :data => social_contract.data, :status => social_contract.status, :type => social_contract.type, :message => social_contract.message}.as_json
              end

              def update
                social_contract = ::Operations::Products::Clinics::SocialContracts::Entities::Update.new(params)
                render :json => {:save => social_contract.save, :data => social_contract.data, :status => social_contract.status, :type => social_contract.type, :message => social_contract.message}.as_json
              end
              
              def read
                social_contract = ::Operations::Products::Clinics::SocialContracts::Entities::Read.new(params)
                render :json => {:data => social_contract.data, :process => social_contract.process?, :type => social_contract.type, :message => social_contract.message}.as_json
              end

              def list
                list = ::Operations::Products::Clinics::SocialContracts::Entities::List.new(params)
                render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
              end
            end
          end
        end
      end
    end
  end
end