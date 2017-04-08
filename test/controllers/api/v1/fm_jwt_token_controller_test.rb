require 'test_helper'

module Api
  module V1
    class FmJwtTokenControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
        switch_anonymity_on(false)
      end

      teardown do
        Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
      end


      test "should get auth token with anonymous users on" do
        switch_anonymity_on(true)
        basic_api_auth

        get :show, format: :json
        assert_response :success
      end

      test "should not get auth token with anonymous users off" do
        basic_api_auth

        assert_raise User::NotAuthorized do
          get :show, format: :json
        end
      end

      test "should get auth token with anonymous users off" do
        basic_api_auth
        sign_in users(:registered_user_1), scope: :user

        get :show, format: :json
        assert_not_nil assigns(:token)
        assert_response :success
      end

      test "should get auth token with anonymous users off and json login data" do
        basic_api_auth

        post :create, params: {username: users(:registered_user_1).email, password: 'Password123'}, format: :json
        assert_response :success
        assert_not_nil assigns(:token)
      end

      test 'should destroy device on logout' do
        basic_api_auth
        user = users(:registered_user_1)
        sign_in user, scope: :user
        delete :destroy
        assert_response :success
        assert_equal 1, Device.unscoped.where(user: user, tombstone: true).count
        assert_equal user.id, Device.unscoped.where(user: user, tombstone: true).first.user.id
      end

      def switch_anonymity_on(turn_on)
        Rails.application.config.allow_anonymous_users = turn_on
      end

    end
  end
end
