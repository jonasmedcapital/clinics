module Users
  module Accounts
    module Phones
      class Update    
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @record_params = params.require(:record).permit(:account_id, :company_id, :record_type)
          @phone_params = params.require(:phone).permit(:id, :ddd, :number, :uniq_number, :kind, :is_main, :notes, :active)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

          @can_current_user_update_phone = can_current_user_update_phone?

          return false unless @can_current_user_update_phone
          
          @phone = phone
          @phone.attributes = @phone_params
          @valid = @phone.valid?
        end

        def phone
          @phone ||= ::Users::Accounts::PhoneRepository.find_by_id(@phone_params[:id])
        end

        def process?
          return false unless @can_current_user_update_phone
          true
        end

        def status
          return :forbidden unless @can_current_user_update_phone
          if @valid
            return :ok
          else
            return :bad_request
          end
        end

        def message
          return message = "A ação não é permitida" unless @can_current_user_update_phone
          if @valid
            message = "Telefone atualizado com sucesso!"
            return message
          else
            message = "Tivemos seguinte(s) problema(s):"
            i = 0
            @phone.errors.messages.each do |key, value|
              i += 1
              message += " (#{i}) #{value.first}"
            end
            return message
          end
        end

        def type
          return "danger" unless @can_current_user_update_phone
          if @valid
            return "success"
          else
            return "danger"
          end
        end

        def save
          return false unless @can_current_user_update_phone
          ActiveRecord::Base.transaction do
            if @valid
              @phone.save
              true
            else
              false
              raise ActiveRecord::Rollback
            end
          end
        end

        def data
          return cln = [] unless @can_current_user_update_phone
          if @valid
            cln = ::Users::Accounts::PhoneRepository.read(@phone)
          else
            cln = []
          end
          
          return {:cln => cln.compact}.as_json
        end

        private

        def can_current_user_update_phone?
          ::UserPolicies.new(@current_user_params[:current_user_id], "update", @current_user_params[:feature]).can_current_user?
        end

      end
    end
  end
end