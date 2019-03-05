# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PhotoCon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    Rails.application.routes.default_url_options = {
    host: 'example.com'
}
    config.autoload_paths += Dir.glob("#{config.root}/app/interactions/*")
    config.assets.initialize_on_precompile = false
    config.active_job.queue_adapter = :sidekiq
    config.load_defaults 5.2
    config.api_only = false
    config.i18n.default_locale = :ru
    ENV['VKONTAKTE_KEY'] = Rails.application.credentials.dig(:vkontakte_key)
    ENV['VKONTAKTE_SECRET'] = Rails.application.credentials.dig(:vkontakte_secret)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
