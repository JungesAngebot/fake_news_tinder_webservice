require 'test_helper'

module Api
  module V1
    class QuizInformationsControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @quiz_information = quiz_informations(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:quiz_informations)
      end

      test "should show quiz_information" do
        get :show, params: {id: @quiz_information}, format: :json
        assert_response :success
      end


      # test "should create quiz_information" do
      #   assert_difference('QuizInformation.count', 1) do
      #     post :create, params: {quiz_information: cleaned_attributes(@quiz_information.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:quiz_information)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@quiz_information.attributes).keys.sort
      # end
      #
      # test "should update quiz_information" do
      #   patch :update, params: {id: @quiz_information.id, quiz_information: cleaned_attributes(@quiz_information.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:quiz_information)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@quiz_information.attributes).keys.sort
      # end
      #
      # test "should destroy quiz_information" do
      #   assert_difference('QuizInformation.count', -1) do
      #     delete :destroy, params: {id: @quiz_information.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
