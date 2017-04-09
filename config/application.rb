require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FakeNewsQuiz
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.title = 'fake news quiz webservice'

    config.title_internal = 'fake_news_quiz_webservice'

    # must not have an underscore
    config.app_url_scheme = 'fnquiz'

    config.autoload_paths += %W(#{config.root}/app/uploaders)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :en

    config.to_prepare do
      Devise::SessionsController.layout "login"
      Devise::ConfirmationsController.layout "login"
      Devise::UnlocksController.layout "login"
      Devise::PasswordsController.layout "login"
      DeviseController.respond_to :html
    end

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

    config.active_support.test_order = :sorted

    config.allow_anonymous_users = true

    config.action_dispatch.rescue_responses = config.action_dispatch.rescue_responses.merge(
        'User::NotAuthorized' => :unauthorized
    )
  end
end
