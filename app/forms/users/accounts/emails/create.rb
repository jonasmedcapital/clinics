module Users
  module Accounts
    module Emails
      class Create    
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @record_params = params.require(:record).permit(:account_id, :company_id, :record_type)
          @email_params = params.require(:email).permit(:id, :address, :kind, :is_main, :notes)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

          # @can_current_user_create_email = can_current_user_create_email?
          # return false unless @can_current_user_create_email
          
          @email = email
          @email.attributes = @email_params
          @valid = @email.valid?
        end

        def email
          if @record_params[:record_type] == "account_entities"
            ::Users::Accounts::EmailRepository.build(@record_params[:account_id], @record_params[:record_type])
          elsif @record_params[:record_type] == "company_entities"
            ::Users::Accounts::EmailRepository.build(@record_params[:company_id], @record_params[:record_type])
          end
        end
        
        def process?
          # return false unless @can_current_user_create_email
          true
        end

        def status
          # return :forbidden unless @can_current_user_create_email
          if @valid
            return :created
          else
            return :bad_request
          end
        end

        def message
          # return message = "A ação não é permitida" unless @can_current_user_create_email
          if @valid
            message = "E-mail criado com sucesso!"
            return message
          else
            message = "Tivemos seguinte(s) problema(s):"
            i = 0
            @email.errors.messages.each do |key, value|
              i += 1
              message += " (#{i}) #{value.first}"
            end
            return message
          end
        end

        def type
          # return "danger" unless @can_current_user_create_email
          if @valid
            return "success"
          else
            return "danger"
          end
        end

        def save
          # return false unless @can_current_user_create_email
          ActiveRecord::Base.transaction do
            if @valid
              @email.save
              true
            else
              false
              raise ActiveRecord::Rollback
            end
          end
        end

        def data
          # return cln = [] unless @can_current_user_create_email
          if @valid
            cln = ::Users::Accounts::EmailRepository.read(@email)
          else
            cln = []
          end
          
          return {:cln => cln.compact}.as_json
        end

        private

        def can_current_user_create_email?
          ::UserPolicies.new(@current_user_params[:current_user_id], "create", @current_user_params[:feature]).can_current_user?
        end

      end
    end
  end
end