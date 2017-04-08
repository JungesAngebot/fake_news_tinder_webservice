require 'test_helper'

module Api
  module V1
    class FmRegistrationsControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
        switch_anonymity_on(false)
      end

      teardown do
        Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
      end

      test 'should change password authenticated' do
        user = users(:registered_user_1)
        assert user.valid_password?('Password123')
        sign_in user, scope: :user
        params = {current_password: 'Password123', password: 'NewPassword123', password_confirmation: 'NewPassword123'}
        put :update, params: {user: params}, format: :json
        assert_response :success
        user.reload
        assert user.valid_password?('NewPassword123')
      end

      test 'should not change password wrong current_password' do
        user = users(:registered_user_1)
        assert user.valid_password?('Password123')
        #sign_in :user, user
        params = {current_password: 'wrong password', password: 'NewPassword123', password_confirmation: 'NewPassword123'}
        put :update, params: {user: params}, format: :json
        assert_response :unauthorized
      end

      test 'should not change password unauthenticated' do
        user = users(:registered_user_1)
        assert user.valid_password?('Password123')
        #sign_in :user, user
        params = {current_password: 'Password123', password: 'NewPassword123', password_confirmation: 'NewPassword123'}
        put :update, params: {user: params}, format: :json
        assert_response :unauthorized
      end


      def switch_anonymity_on(turn_on)
        Rails.application.config.allow_anonymous_users = turn_on
      end

    end
  end
end
