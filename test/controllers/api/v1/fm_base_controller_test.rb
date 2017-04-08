require 'test_helper'

module Api
  module V1
    class FmBaseControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
        switch_anonymity_on(false)
      end

      teardown do
        Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
      end

      test "should get nothing authenticated" do
        switch_anonymity_on(true)
        basic_api_auth

        get :authenticated_nothing, format: :json
        assert_response :success
      end

      test "should not get nothing authenticated" do
        @request.headers['X-Api-Token'] = 'Invalid Api Token'

        assert_raise User::NotAuthorized do
          get :authenticated_nothing, format: :json
        end
      end

      test 'should be api key authenticated' do
        switch_anonymity_on(true)
        api_setup
        get :authenticated_nothing
        assert_response :success
      end

      test 'api access returns device uuid' do
        switch_anonymity_on(true)
        api_setup
        get :authenticated_nothing
        assert @response.headers['X-Device-Uuid'].present?
      end

      test 'api access created device with guest user' do
        switch_anonymity_on(true)
        api_setup
        assert_difference('User.count') do
          assert_difference('Device.count') do
            get :authenticated_nothing
          end
        end
        device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
        assert device
        assert device.user
        assert device.user.email.ends_with?(User::GUEST_EMAIL)
      end

      test 'all metadata saved' do
        switch_anonymity_on(true)
        api_setup
        headers = fluid_headers
        @request.headers.merge!(headers)
        get :authenticated_nothing
        device = Device.find_by(uuid: @response.headers['X-Device-Uuid'])
        assert device.notification_token == headers['X-Notification-Token']
        assert device.os == headers['X-Os']
        assert device.os_version == headers['X-Os-Version']
        assert device.os_version_code == headers['X-Os-Version-Code']
        assert device.device_model == headers['X-Device-Model']
        assert device.device_manufacturer == headers['X-Device-Manufacturer']
        assert device.app_version == headers['X-App-Version']
        assert device.device_resolution_height == headers['X-Device-Resolution-Height']
        assert device.device_resolution_width == headers['X-Device-Resolution-Width']
        assert device.device_diagonal == headers['X-Device-Diagonal']
        assert device.developer == headers['X-Developer']
        assert device.statistic_flag == headers['X-Statistic-Flag']
      end

      test 'unauthorized when API TOKEN wrong' do
        @request.headers['X-Api-Token'] = 'wrong api token'
        @request.format = :json
        assert_raise User::NotAuthorized do
          get :authenticated_nothing
        end
      end

      test 'redirect when api token not given but json' do
        @request.format = :json
        assert_raise User::NotAuthorized do
          get :authenticated_nothing
        end
      end

      private

        def api_setup
          @request.headers['X-Api-Token'] = ENV['API_TOKEN']
          @request.format = :json
        end

        def switch_anonymity_on(turn_on)
          Rails.application.config.allow_anonymous_users = turn_on
        end

    end
  end
end