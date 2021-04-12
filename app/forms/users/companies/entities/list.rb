module Users
  module Companies
    module Entities
      class List
        include ActiveModel::Model

        attr_accessor :status, :type, :message

        def initialize(params)
          @company_params = params.require(:company).permit(:active, :kind, :subkind)
          @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)
          
          # @can_current_user_list_company = can_current_user_list_company?
          # return false unless @can_current_user_list_company
          @companies = companies

        end

        def companies
          if @company_params[:subkind].presence.nil?
            @companies ||= ::Users::Companies::EntityRepository.all_active_by_kind(@company_params[:kind])
          elsif @company_params[:subkind].presence.present?
            @companies ||= ::Users::Companies::EntityRepository.all_active_by_subkind(@company_params[:subkind])
          end
        end
        
        def current_user
          @current_user ||= ::Users::UserRepository.new.find_by_id(@current_user_params[:current_user_id])
        end
        
        def process?
          # return false unless @can_current_user_list_company
          true
        end

        def status
          # return :forbidden unless @can_current_user_list_company
          :ok
        end
        

        def data
          # return cln = [] unless @can_current_user_list_company
          # cln = ::Users::Companies::EntityRepository.list_all_with_permissions @companies, current_user, @company_params[:kind]
          cln = ::Users::Companies::EntityRepository.list_all(@companies)

          return {:cln => cln.compact}.as_json
        end

        def message
          # return message = "A ação não é permitida" unless @can_current_user_list_company
        end

        def type
          # return "danger" unless @can_current_user_list_company
        end

        private

        def can_current_user_list_company?
          ::UserPolicies.new(@current_user_params[:current_user_id], "list", @current_user_params[:feature]).can_current_user?
        end
        


      end
    end
  end
end