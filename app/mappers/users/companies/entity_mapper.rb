module Users
  module Companies
    class EntityMapper

      def self.map model
        obj = model.attributes
        email = model._email
        phone = model._phone
        address = model._address

        if model._email.present?
          email_attrs = email.attributes
          email_attrs = email_attrs.merge({"kind_pretty" => ::Users::Accounts::EmailRepository::ENUM_KIND[email.kind]})
        else
          email_attrs = {}
        end

        if model._phone.present?
          phone_attrs = phone.attributes
          phone_attrs = phone_attrs.merge({"kind_pretty" => ::Users::Accounts::PhoneRepository::ENUM_KIND[phone.kind]})
        else
          phone_attrs = {}
        end

        if model._address.present?
          address_attrs = address.attributes
          address_attrs = address_attrs.merge({"kind_pretty" => ::Users::Accounts::AddressRepository::ENUM_KIND[address.kind]})
          address_attrs = address_attrs.merge({"postal_code_pretty" => ContactDecorator.new(address).postal_code_pretty})
        else
          address_attrs = {}
        end
        
        obj = obj.merge({ "cnpj_pretty" => model.cnpj_pretty })
        obj = obj.merge({ "subkind_pretty" => ::Users::Companies::EntityRepository::ENUM_SUBKIND[model.subkind.first] }) if model.subkind
        # obj = obj.merge({ "class_type" => ::App::ClassName::FromSchema::TRANSLATE[model.class.name] })
        obj = obj.merge({ "email" => email_attrs })
        obj = obj.merge({ "phone" => phone_attrs })
        obj = obj.merge({ "address" => address_attrs })

        return obj
      end

      def map_collection model_collection
        model_collection.map{ |model| map(model) }
      end
      
      def self.map_all_active model_collection
        model_collection.where(active: true).map{ |model| map(model) }
      end

      def self.map_report entity, kind
        data = {}
        data = data.merge({"company_total" => entity.where(active: true).where("? = ANY (kind)", kind).count})
        data = data.merge({"company_kind" => ::Users::Companies::HumanizeCompanyKind::NAME[kind]})
        data = data.merge({"company_url" => ::Users::Companies::HumanizeCompanyKind::URL[kind]})
      end

      def self.report_with_permissions entity, current_user, feature
        collection = map_report(entity, feature)
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

      def self.map_all_with_permissions model_collection, current_user, feature
        collection = model_collection.map{ |model| map(model) }
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

      def self.map_with_permissions model, current_user, feature
        collection = map model
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

    end
  end
end