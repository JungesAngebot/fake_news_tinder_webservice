ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'controllers/concerns/basic_api_auth'

require 'rails-controller-testing'
Rails::Controller::Testing.install

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Add more helper methods to be used by all tests here...

end

class ActionController::TestCase
  # ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...

  # Add more helper methods to be used by all tests here...

  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  def fluid_headers
    {
        'X-Notification-Token' => SecureRandom.hex,
        'X-Os' => SecureRandom.hex,
        'X-Os-Version' => SecureRandom.hex,
        'X-Os-Version-Code' => rand(100000),
        'X-Device-Model' => SecureRandom.hex,
        'X-Device-Manufacturer' => SecureRandom.hex,
        'X-App-Version' => SecureRandom.hex,
        'X-App-Version-Int' => rand(100000),
        'X-Device-Resolution-Height' => rand(100000),
        'X-Device-Resolution-Width' => rand(100000),
        'X-Device-Diagonal' => rand(100000),
        'X-Developer' => true,
        'X-Statistical-Flag' => false,
    }
  end

  def cleaned_attributes(attributes)
    attributes.delete('tombstone')
    attributes.delete('created_at')
    attributes.delete('updated_at')
    attributes
  end

  def teardown
    Warden.test_reset!
  end
end
