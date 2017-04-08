require 'test_helper'

module Api
  module V1
    class InformationTypesControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @information_type = information_types(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:information_types)
      end

      test "should show information_type" do
        get :show, params: {id: @information_type}, format: :json
        assert_response :success
      end

      #
      # test "should create information_type" do
      #   assert_difference('InformationType.count', 1) do
      #     post :create, params: {information_type: cleaned_attributes(@information_type.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:information_type)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@information_type.attributes).keys.sort
      # end
      #
      # test "should update information_type" do
      #   patch :update, params: {id: @information_type.id, information_type: cleaned_attributes(@information_type.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:information_type)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@information_type.attributes).keys.sort
      # end
      #
      # test "should destroy information_type" do
      #   assert_difference('InformationType.count', -1) do
      #     delete :destroy, params: {id: @information_type.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
