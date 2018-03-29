require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Comeals
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins /\A.*comeals.*\z/
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :delete, :options], credentials: true
      end
    end

    # Disable Strong Params
    config.action_controller.permit_all_parameters = true

    # Set Time Zone
    config.time_zone = "America/Los_Angeles"
  end
end
