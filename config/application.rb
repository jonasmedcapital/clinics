require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clinics
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Brasilia'
    # config.i18n.default_locale = :'pt-BR'

    config.exceptions_app = self.routes
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths << "#{Rails.root}/app/operations"
    # config.eager_load_paths << "#{Rails.root}/app/operations"
    # config.autoload_paths << "#{Rails.root}/app/inputs"
    # config.eager_load_paths << "#{Rails.root}/app/inputs"
    config.autoload_paths << "#{Rails.root}/app/services"
    config.eager_load_paths << "#{Rails.root}/app/services"
    config.autoload_paths << "#{Rails.root}/app/decorators"
    config.eager_load_paths << "#{Rails.root}/app/decorators"
    config.autoload_paths << "#{Rails.root}/app/repositories"
    config.eager_load_paths << "#{Rails.root}/app/repositories"
    config.autoload_paths << "#{Rails.root}/app/mappers"
    config.eager_load_paths << "#{Rails.root}/app/mappers"
    config.autoload_paths << "#{Rails.root}/app/policies"
    config.eager_load_paths << "#{Rails.root}/app/policies"
    config.autoload_paths << "#{Rails.root}/app/libraries"
    config.eager_load_paths << "#{Rails.root}/app/libraries"
    config.autoload_paths << "#{Rails.root}/app/permissions"
    config.eager_load_paths << "#{Rails.root}/app/permissions"
    config.autoload_paths << "#{Rails.root}/app/decorators"
    config.eager_load_paths << "#{Rails.root}/app/decorators"
    
  end
end
