require_relative 'boot'

require 'csv'
require 'rails/all'
require 'barby'
require 'barby/barcode/gs1_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'rqrcode'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Coquetin
  class Application < Rails::Application
    
    config.action_mailer.default_url_options = { host: 'imahsoftware.com' }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #config.active_record.default_timezone = 'America/Bogota'
    config.time_zone = "America/Bogota"
    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    I18n.config.enforce_available_locales = true
    config.i18n.available_locales = [:es, :en]
    config.i18n.default_locale = :es
    config.exceptions_app = self.routes

    config.second_base.run_with_db_tasks = false

    config.second_base.path = 'db/secondbase'
    config.second_base.config_key = 'secondbase'

    # server de jobs
    config.active_job.queue_adapter = :inline
    #config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
    #config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }
    #config.cache_store = :memory_store
  end
end
