module Users
  module Accounts
    module Entities
      class List
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:active, :kind)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

          @can_current_user_list_account = can_current_user_list_account?
          
          return false unless @can_current_user_list_account
          @accounts = accounts
        end

        def accounts
          @accounts ||= ::Users::Accounts::EntityRepository.all_active_by_kind(@account_params[:kind])
        end
        
        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          return false unless @can_current_user_list_account
          true
        end

        def status
          return :forbidden unless @can_current_user_list_account
          :ok
        end
        

        def data
          return cln = [] unless @can_current_user_list_account
          cln = ::Users::Accounts::EntityRepository.list_all_with_permissions @accounts, current_user, @account_params[:kind]
          return {:cln => cln.compact}.as_json
        end

        def message
          return message = "A ação não é permitida" unless @can_current_user_list_account
        end

        def type
          return "danger" unless @can_current_user_list_account
        end

        private

        def can_current_user_list_account?
          ::UserPolicies.new(@current_user_params[:current_user_id], "list", @current_user_params[:feature]).can_current_user?
        end
        


      end
    end
  end
end