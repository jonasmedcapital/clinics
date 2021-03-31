module Users
  module Accounts
    class EntityMapper

      def self.simple_map model
        obj = model.attributes

        obj = obj.merge({ "nickname" => ::Users::UserRepository.nickname(model.user) })

        return obj
      end

      def self.simple_map_all collection
        collection.map{ |model| simple_map(model) }
      end

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

        obj = obj.merge({ "has_user" => model.user_id.present? })
        obj = obj.merge({ "cpf_pretty" => ::AccountDecorator.new(model).cpf_pretty })
        obj = obj.merge({ "sex_pretty" => ::Users::Accounts::EntityRepository::ENUM_SEX[model.sex] })
        obj = obj.merge({ "kind_pretty" => model.kind.map{ |kind| ::Users::Accounts::EntityRepository::ENUM_KIND[kind] } })
        obj = obj.merge({ "birthdate_pretty" => ::DateDecorator.pick_date(model.birthdate) }) if model.birthdate
        obj = obj.merge({ "class_type" => ::App::ClassName::FromSchema::TRANSLATE[model.class.name] })
        obj = obj.merge({ "emails_count" => ::Users::Accounts::EmailRepository.all_active_count(model) })
        obj = obj.merge({ "email" => email_attrs })
        obj = obj.merge({ "phone" => phone_attrs })
        obj = obj.merge({ "address" => address_attrs })

        return obj
      end

      def self.map_user_with_permisssion model, current_user
        model_class = model.class
        model_attributes = model.attributes
        model_attributes = model_attributes.merge({ "blocked_pretty" =>  model.blocked ? "Bloqueado" : "Ativo" })
        model_attributes = model_attributes.merge({ "admin" => model.__admin? })
        model_attributes = model_attributes.merge({ "team" => model.__team? })
        model_attributes = model_attributes.merge({ "doctor" => model.__doctor? })
        model_attributes = model_attributes.merge({ "cpf_pretty" => ::AccountDecorator.new(model).cpf_pretty })
        model_attributes = model_attributes.merge({ "has_avatar" => model.avatar.attached? })
        model_attributes = model_attributes.merge({ "avatar_url" => model.avatar.attached? ? model.avatar.blob.service_url : nil })
        model_attributes = model_attributes.merge({ "permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, "users") })
        model_attributes = model_attributes.merge({ "has_unconfirmed_email" => model.unconfirmed_email? })
        model_attributes = model_attributes.merge({ "has_unconfirmed" => !model.confirmed_at? })
        model_attributes = model_attributes.merge({ "confirmation_token" => model.confirmation_token })
        model_attributes = model_attributes.merge({ "confirmation_link" => "#{ENV['DEFAULT_URL_HOST']}/confirmation?confirmation_token=#{model.confirmation_token}" })
        model_attributes = model_attributes.merge({ "created_at_full" => model.created_at ? "Criado em #{model.created_at.day} de #{I18n.t("date.month_names")[model.created_at.month]} de #{model.created_at.year}" : "Não Definido" })
        model_attributes = model_attributes.merge({ "confirmed_at_full" => model.confirmed_at ? "Confirmado em #{model.confirmed_at.day} de #{I18n.t("date.month_names")[model.confirmed_at.month]} de #{model.confirmed_at.year}" : "Não Definido" })
        model_attributes = model_attributes.merge({ "last_sign_in_at_full" => model.last_sign_in_at ? "Último acesso em #{model.last_sign_in_at.day} de #{I18n.t("date.month_names")[model.last_sign_in_at.month]} de #{model.last_sign_in_at.year}" : "Não Definido" })
        model_attributes
      end

      def self.map_products_with_permisssion account, current_user
        products = {}
        permissions = {}
        ["medpf", "medbooking", "medreturn", "medclinic", "medfat", "medseg"].each do |product|

          products = products.merge({product => [::Operations::Products::EntityRepository.list_all_active_by_account_and_name(account.id, product), ::Operations::Products::EntityRepository::ENUM_NAME[product]]})
          permissions = permissions.merge({product => ::Users::PermissionRepository.find_by_feature_name(current_user, product)})

        end
        {products: products, permissions: permissions}
      end

      def self.map_report entity, kind
        data = {}
        data = data.merge({"account_total" => entity.where(active: true).where("? = ANY (kind)", kind).count})
        data = data.merge({"account_kind" => ::Users::Accounts::HumanizeAccountKind::NAME[kind]})
        data = data.merge({"account_url" => ::Users::Accounts::HumanizeAccountKind::URL[kind]})
      end
      

      def map_collection model_collection
        model_collection.map{ |model| map(model) }
      end
      

      def map_all_active model_collection
        model_collection.where(active: true).map{ |model| map(model) }
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

      def self.report_with_permissions entity, current_user, feature
        collection = map_report(entity, feature)
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end
      

    end
  end
end