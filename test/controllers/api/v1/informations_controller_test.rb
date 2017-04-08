require 'test_helper'

module Api
  module V1
    class InformationsControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @information = informations(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:informations)
      end

      test "should show information" do
        get :show, params: {id: @information}, format: :json
        assert_response :success
      end


      # test "should create information" do
      #   assert_difference('Information.count', 1) do
      #     post :create, params: {information: cleaned_attributes(@information.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:information)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@information.attributes).keys.sort
      # end
      #
      # test "should update information" do
      #   patch :update, params: {id: @information.id, information: cleaned_attributes(@information.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:information)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@information.attributes).keys.sort
      # end
      #
      # test "should destroy information" do
      #   assert_difference('Information.count', -1) do
      #     delete :destroy, params: {id: @information.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
