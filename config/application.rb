require_relative 'boot'

require 'rails/all'
require "active_model/railtie"
require "active_job/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Beekeeper
  class Application < Rails::Application
    config.assets.paths << "app/assets"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_job.queue_adapter = :sidekiq
    # config.assets.paths << Rails.root.join('assets', 'fonts')
    # config.assets.precompile << /.(?:svg|eot|woff|ttf)$/

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # inside config/application.rb
  end
end
