class Users::Accounts::Addresses::CitiesByState
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @state_params = params.require(:state).permit(:state)
    @current_user_params = params.require(:current_user).permit(:current_user_id)
    @cities = ::Users::Accounts::Cities::SELECTION.select{|line| line[:state] == @state_params[:state]}.map{|line| line[:city]}.sort
  end

  def current_user
    @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
  end
  
  def process?
    return false unless @cities.present?
    true
  end
  

  def data
    return {:cln => @cities}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @cities.present?
  end

  def type
    return "danger" unless @cities.present?
  end

end