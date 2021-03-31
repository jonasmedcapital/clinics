module Users
  module Accounts
    module Entities
      class Create    
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @kind_params = params.require(:kind).permit(:kind)
          @account_params = params.require(:account).permit(:active, :name, :cpf, :birthdate, :sex, :notes)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

          # @can_current_user_create_account = can_current_user_create_account?
          # return false unless @can_current_user_create_account
          
          @account = account
          @account.attributes = @account_params
          @valid = @account.valid?
        end

        def account
          @account ||= ::Users::Accounts::EntityRepository.build(@kind_params[:kind])
        end

        def process?
          # return false unless @can_current_user_create_account
          if @valid
            true
          else
            false
          end
        end

        def status
          # return :forbidden unless @can_current_user_create_account
          if @valid
            return :created
          else
            return :bad_request
          end
        end

        def message
          # return message = "A ação não é permitida" unless @can_current_user_create_account
          if @valid
            message = "Conta criada com sucesso!"
            return message
          else
            message = "Tivemos seguinte(s) problema(s):"
            i = 0
            @account.errors.messages.each do |key, value|
              i += 1
              message += " (#{i}) #{value.first}"
            end
            return message
          end
        end

        def type
          # return "danger" unless @can_current_user_create_account
          if @valid
            return "success"
          else
            return "danger"
          end
        end

        def save
          # return false unless @can_current_user_create_account
          ActiveRecord::Base.transaction do
            if @valid
              @account.save
              # ::Users::Accounts::CreateDocumentService.new(@account).create_document
              true
            else
              false
              raise ActiveRecord::Rollback
            end
          end
        end

        def data
          # return cln = [] unless @can_current_user_create_account
          if @valid
            cln = ::Users::Accounts::EntityRepository.read(@account)
          else
            cln = []
          end
          
          return {:cln => cln}.as_json
        end

        private

        def can_current_user_create_account?
          ::UserPolicies.new(@current_user_params[:current_user_id], "create", @current_user_params[:feature]).can_current_user?
        end

      end
    end
  end
end