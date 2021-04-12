class API::V1::Nfe::InvoicesController < ApplicationController

  def create
    entity = ::Nfe::Invoices::Create.new(params)
    render :json => {:save => entity.save, :data => entity.data, :status => entity.status, :type => entity.type, :message => entity.message}.as_json
  end

  def delete
    entity = ::Nfe::Invoices::Delete.new(params)
    render :json => {:status => entity.status, :process => entity.process?, :type => entity.type, :message => entity.message, :data => entity.data}.as_json
  end
  
  def read
    entity = ::Nfe::Invoices::Read.new(params)
    render :json => {:status => entity.status, :process => entity.process?, :type => entity.type, :message => entity.message, :data => entity.data}.as_json
  end

  def list
    list = ::Nfe::Invoices::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end

end