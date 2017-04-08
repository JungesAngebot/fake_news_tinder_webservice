require 'test_helper'

module Api
  module V1
    class FmPasswordsControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
        switch_anonymity_on(false)
      end

      teardown do
        Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
      end

      test 'should redirect to app' do
        token = 'any_token'
        get :edit, params: {reset_password_token: token}
        assert_redirected_to "#{Rails.application.config.app_url_scheme}://forgot_password?reset_password_token=#{token}"
      end

      test 'should create reset instructions for password for available email' do
        params = {email: users(:registered_user_1).email}
        post :create, params: {user: params}, format: :json
        assert_response :success
      end

      test 'should not create reset instructions for password for unavailable email' do
        params = {email: "random_email@example.org"}
        post :create, params: {user: params}, format: :json
        assert_response :unprocessable_entity
      end

      test 'should change password' do
        user = users(:registered_user_1)
        token = user.send_reset_password_instructions
        params = {reset_password_token: token, password: 'NewPassword1', password_confirmation: 'NewPassword1'}
        put :update, params: {user: params}, format: :json
        assert_response :success
      end

      test 'should not change password' do
        user = users(:registered_user_1)
        token = user.send_reset_password_instructions
        params = {reset_password_token: 'invalid token', password: 'NewPassword1', password_confirmation: 'NewPassword1'}
        put :update, params: {user: params}, format: :json
        assert_response :unprocessable_entity
      end

      def switch_anonymity_on(turn_on)
        Rails.application.config.allow_anonymous_users = turn_on
      end

    end
  end
end
