module Users
  module Accounts
    module Entities
      class Read
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @account_params = params.require(:account).permit(:id, :cpf, :kind)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)
        
          @can_current_user_read_account = can_current_user_read_account?
          return false unless @can_current_user_read_account
          
          @account = account
        end

        def account
          if @account_params[:cpf].present?
            @account ||= ::Users::Accounts::EntityRepository.find_by_cpf_or_initialize_by_cpf_and_kind(@account_params[:cpf], @account_params[:kind])
          elsif @account_params[:id].present?
            @account ||= ::Users::Accounts::EntityRepository.find_by_id(@account_params[:id])
          end
        end
        
        def process?
          return false unless @can_current_user_read_account
          true
        end

        def status
          return :forbidden unless @can_current_user_read_account
          :ok
        end
        

        def data
          return cln = [] unless @can_current_user_read_account
          cln = ::Users::Accounts::EntityRepository.read(@account)
          return {:cln => cln}.as_json
        end

        def message
          return message = "A ação não é permitida" unless @can_current_user_read_account
        end

        def type
          return "danger" unless @can_current_user_read_account
        end

        private

        def can_current_user_read_account?
          ::UserPolicies.new(@current_user_params[:current_user_id], "read", @current_user_params[:feature]).can_current_user?
        end
        


      end
    end
  end
end