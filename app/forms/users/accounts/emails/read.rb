module Users
  module Accounts
    module Emails
      class Read
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:account_id)
          @email_params = params.require(:email).permit(:email_id)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
          
          return false unless can_current_user_read_email?
          @current_user = current_user
          @account = account
          @email = email
        end

        def account
          @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
        end

        def email
          @email ||= ::Users::Accounts::EmailRepository.find_by_id(@email_params[:email_id])
        end

        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          return false unless can_current_user_read_email?
          true
        end

        def status
          return :forbidden unless can_current_user_read_email?
          :ok
        end
        

        def data
          return cln = [] unless can_current_user_read_email?
          if @current_user_params[:permissions]
            cln = ::Users::Accounts::EmailRepository.read_with_permissions @email, @current_user
          else
            cln = ::Users::Accounts::EmailRepository.read @email
          end
          
          return {:cln => cln.compact}.as_json
        end

        def message
          return message = "A ação não é permitida" unless can_current_user_read_email?
        end

        def type
          return "danger" unless can_current_user_read_email?
        end

        private

        def can_current_user_read_email?
          @can_current_user_read_email ||= ::UserPolicies.new(current_user.id, "read", "emails").can_current_user?
        end
        


      end
    end
  end
end