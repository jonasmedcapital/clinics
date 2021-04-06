class Operations::Products::Entities::GetRoom
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @product_params = params.require(:product).permit(:id, :name)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    @can_current_user_read_product = can_current_user_read_product?    
    return false unless @can_current_user_read_product

    @product = product
    update_params = {obj_id: @product.id, obj_type: @product.class.name, room_type: "update"}
    @update_room = room(update_params)

    chat_params = {obj_id: @product.id, obj_type: @product.class.name, room_type: "chat"}
    @chat_room = room(chat_params)
  end

  def product
    @product ||= ::Operations::Products::EntityRepository.find_by_id(@product_params[:id])
  end

  def room(params)
    ::Operations::Messages::RoomRepository.find_by_obj(params)
  end
  
  def process?
    return false unless @can_current_user_read_product
    true
  end

  def status
    return :forbidden unless @can_current_user_read_product
    :ok
  end
  
  def data
    return cln = [] unless @can_current_user_read_product
    update = ::Operations::Messages::RoomRepository.read @update_room if @update_room
    chat = ::Operations::Messages::RoomRepository.read @chat_room if @chat_room


    return {:cln => { :update => update, :chat => chat }}.as_json
  end

  def message
    return message = "A ação não é permitida" unless @can_current_user_read_product
  end

  def type
    return "danger" unless @can_current_user_read_product
  end

  private

  def can_current_user_read_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", @product_params[:name]).can_current_user?
  end
  


end