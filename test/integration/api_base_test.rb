require 'test_helper'

class ApiBaseTest < ActionDispatch::IntegrationTest

  setup do
    @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
    switch_anonymity_on(false)
  end

  teardown do
    Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
  end

  test 'returning device creates not another user' do
    switch_anonymity_on(true)
    headers = fluid_headers
    assert_difference('User.count') do
      assert_difference('Device.count') do
        get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
      end
    end
    headers['X-Device-Uuid'] = @response.headers['X-Device-Uuid']
    assert_no_difference('User.count') do
      assert_no_difference('Device.count') do
        get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
      end
    end
  end

  test 'device handling' do
    headers = fluid_headers
    get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers

    first_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
    headers['X-Device-Uuid'] = @response.headers['X-Device-Uuid']
    get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers

    second_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
    assert first_device == second_device
  end

  test 'notification token changed handling' do
    switch_anonymity_on(true)
    headers = fluid_headers
    old_notification_token = headers['X-Notification-Token']
    get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
    first_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
    new_notification_token = SecureRandom.hex
    headers['X-Notification-Token'] = new_notification_token
    headers['X-Device-Uuid'] = @response.headers['X-Device-Uuid']
    get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
    second_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
    assert first_device == second_device
    assert second_device.notification_token != old_notification_token
    assert second_device.notification_token == new_notification_token
  end

  test 'device matching with notification token' do
    switch_anonymity_on(true)
    headers = fluid_headers
    notification_token = headers['X-Notification-Token']
    get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
    first_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])

    assert_no_difference('Device.count') do
      headers = fluid_headers
      headers['X-Notification-Token'] = notification_token
      get '/api/v1/api_authenticated_nothing.json', params: {}, headers: headers
    end
    second_device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
    assert first_device != second_device
    assert first_device.notification_token == second_device.notification_token
  end

  def fluid_headers
    {
        'X-Api-Token' => ENV['API_TOKEN'],
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

  def switch_anonymity_on(turn_on)
    Rails.application.config.allow_anonymous_users = turn_on
  end

end
