module Users
  module Accounts
    module Phones
      class Read
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:account_id)
          @phone_params = params.require(:phone).permit(:phone_id)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
          
          return false unless can_current_user_read_phone?
          @current_user = current_user
          @account = account
          @phone = phone
        end

        def account
          @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
        end

        def phone
          @phone ||= ::Users::Accounts::PhoneRepository.find_by_id(@phone_params[:phone_id])
        end

        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          return false unless can_current_user_read_phone?
          true
        end

        def status
          return :forbidden unless can_current_user_read_phone?
          :ok
        end
        

        def data
          return cln = [] unless can_current_user_read_phone?
          if @current_user_params[:permissions]
            cln = ::Users::Accounts::PhoneRepository.read_with_permissions @phone, @current_user
          else
            cln = ::Users::Accounts::PhoneRepository.read @phone
          end
          
          return {:cln => cln.compact}.as_json
        end

        def message
          return message = "A ação não é permitida" unless can_current_user_read_phone?
        end

        def type
          return "danger" unless can_current_user_read_phone?
        end

        private

        def can_current_user_read_phone?
          @can_current_user_read_phone ||= ::UserPolicies.new(current_user.id, "read", "phones").can_current_user?
        end
        


      end
    end
  end
end