module Users
  module Accounts
    module Phones
      class List
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:account_id)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
          
          return false unless can_current_user_list_phone?
          @current_user = current_user
          @account = account
          @phones = phones
        end

        def phones
          @phones ||= ::Users::Accounts::PhoneRepository.all_active_by_account(@account_params[:account_id])
        end

        def account
          @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
        end

        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          return false unless can_current_user_list_phone?
          true
        end

        def status
          return :forbidden unless can_current_user_list_phone?
          :ok
        end
        

        def data
          return cln = [] unless can_current_user_list_phone?
          if @current_user_params[:permissions]
            cln = ::Users::Accounts::PhoneRepository.list_all_with_permissions @phones, @current_user
          else
            cln = ::Users::Accounts::PhoneRepository.list_all @phones
          end
          
          return {:cln => cln.compact}.as_json
        end

        def message
          return message = "A ação não é permitida" unless can_current_user_list_phone?
        end

        def type
          return "danger" unless can_current_user_list_phone?
        end

        private

        def can_current_user_list_phone?
          @can_current_user_list_phone ||= ::UserPolicies.new(current_user.id, "list", "phones").can_current_user?
        end
        


      end
    end
  end
end