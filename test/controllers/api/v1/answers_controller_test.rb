require 'test_helper'

module Api
  module V1
    class AnswersControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @answer = answers(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:answers)
      end

      test "should show answer" do
        get :show, params: {id: @answer}, format: :json
        assert_response :success
      end
      #
      #
      # test "should create answer" do
      #   assert_difference('Answer.count', 1) do
      #     post :create, params: {answer: cleaned_attributes(@answer.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:answer)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@answer.attributes).keys.sort
      # end
      #
      # test "should update answer" do
      #   patch :update, params: {id: @answer.id, answer: cleaned_attributes(@answer.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:answer)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@answer.attributes).keys.sort
      # end
      #
      # test "should destroy answer" do
      #   assert_difference('Answer.count', -1) do
      #     delete :destroy, params: {id: @answer.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
