require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JsonapiExample
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.view_specs false
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.system_tests false
      g.orm :active_record
      g.test_framework :rspec,
        fixture: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: true
    end

    # Don't generate system test files.
    config.generators.system_tests = nil

    class ValidationError < Committee::ValidationError
      def error_body
        {
          errors: [
            { status: id, detail: message }
          ]
        }
      end

      def render
        [
          status,
          { "Content-Type" => "application/vnd.api+json" },
          [JSON.generate(error_body)]
        ]
      end
    end

    config.middleware.use Committee::Middleware::RequestValidation, schema_path: Rails.root.join('schema', 'openapi.yml'), error_class: ValidationError
    config.middleware.use Committee::Middleware::ResponseValidation, schema_path: Rails.root.join('schema', 'openapi.yml'), error_class: ValidationError if Rails.env.development?
  end
end
