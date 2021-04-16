class API::V1::Nfe::InvoicesController < ApplicationController

  def create
    invoice = ::Nfe::Invoices::Create.new(params)
    render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
  end

  def delete
    invoice = ::Nfe::Invoices::Delete.new(params)
    render :json => {:status => invoice.status, :process => invoice.process?, :type => invoice.type, :message => invoice.message, :data => invoice.data}.as_json
  end
  
  def read
    invoice = ::Nfe::Invoices::Read.new(params)
    render :json => {:status => invoice.status, :process => invoice.process?, :type => invoice.type, :message => invoice.message, :data => invoice.data}.as_json
  end

  def list
    list = ::Nfe::Invoices::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end

end