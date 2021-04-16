class API::V1::Nfe::CompaniesController < ApplicationController

  def create
    company = ::Nfe::Companies::Create.new(params)
    render :json => {:save => company.save, :data => company.data, :status => company.status, :type => company.type, :message => company.message}.as_json
  end

  def delete
    company = ::Nfe::Companies::Delete.new(params)
    render :json => {:status => company.status, :process => company.process?, :type => company.type, :message => company.message, :data => company.data}.as_json
  end
  
  def read
    company = ::Nfe::Companies::Read.new(params)
    render :json => {:status => company.status, :process => company.process?, :type => company.type, :message => company.message, :data => company.data}.as_json
  end

  def list
    list = ::Nfe::Companies::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end

end