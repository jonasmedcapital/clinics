module Users
  module Accounts
    class PhoneMapper

      def self.map model
        obj = model.attributes

        obj = obj.merge({ "phone_number" => ContactDecorator.new(model).phone_pretty })
        obj = obj.merge({ "kind_pretty" => ::Users::Accounts::PhoneRepository::ENUM_KIND[model.kind] })

        return obj
      end

      def map_collection model_collection
        model_collection.map{ |model| map(model) }
      end
      
      def map_all_active model_collection
        model_collection.where(active: true).map{ |model| map(model) }
      end

      def self.map_all_with_permissions model_collection, current_user
        collection = model_collection.map{ |model| map(model) }
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, "phones")}
        {:collection => collection, :permissions => permissions}
      end

      def self.map_with_permissions model, current_user
        collection = map model
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, "phones")}
        {:collection => collection, :permissions => permissions}
      end

    end
  end
end