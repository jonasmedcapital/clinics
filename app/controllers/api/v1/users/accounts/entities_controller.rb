class API::V1::Users::Accounts::EntitiesController < ApplicationController

  def create
    account = ::Users::Accounts::Entities::Create.new(params)
    render :json => {:status => account.status, :process => account.process?, :type => account.type, :message => account.message, :save => account.save}.as_json
  end

  def update
    account = ::Users::Accounts::Entities::Update.new(params)
    render :json => {:status => account.status, :process => account.process?, :type => account.type, :message => account.message, :save => account.save}.as_json
  end
  
  def read
    account = ::Users::Accounts::Entities::Read.new(params)
    render :json => {:status => account.status, :process => account.process?, :type => account.type, :message => account.message, :data => account.data}.as_json
  end

  def list
    list = ::Users::Accounts::Entities::List.new(params)
    render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
  end

  def read_user
    user = ::Users::Accounts::Entities::ReadUser.new(params)
    render :json => {:status => user.status, :process => user.process?, :type => user.type, :message => user.message, :data => user.data}.as_json
  end
  
  def read_products
    products = ::Users::Accounts::Entities::ReadProducts.new(params)
    render :json => {:status => products.status, :process => products.process?, :type => products.type, :message => products.message, :data => products.data}.as_json
  end

  def read_taker
    account = ::Users::Accounts::Entities::ReadTaker.new(params)
    render :json => {:status => account.status, :process => account.process?, :type => account.type, :message => account.message, :data => account.data}.as_json
  end
  
end