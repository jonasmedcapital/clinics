module Users
  module Accounts
    module Emails
      class List
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:account_id)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)
          
          return false unless can_current_user_list_email?
          @current_user = current_user
          @account = account
          @emails = emails
        end

        def emails
          @emails ||= ::Users::Accounts::EmailRepository.all_active_by_account_id(@account_params[:account_id])
        end
        
        def account
          @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:account_id])
        end

        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          return false unless can_current_user_list_email?
          true
        end

        def status
          return :forbidden unless can_current_user_list_email?
          :ok
        end
        

        def data
          return cln = [] unless can_current_user_list_email?
          if @current_user_params[:permissions]
            cln = ::Users::Accounts::EmailRepository.list_all_with_permissions @emails, @current_user
          else
            cln = ::Users::Accounts::EmailRepository.list_all @emails
          end
          
          return {:cln => cln.compact}.as_json
        end

        def message
          return message = "A ação não é permitida" unless can_current_user_list_email?
        end

        def type
          return "danger" unless can_current_user_list_email?
        end

        private

        def can_current_user_list_email?
          @can_current_user_list_email ||= ::UserPolicies.new(current_user.id, "list", "emails").can_current_user?
        end
        


      end
    end
  end
end