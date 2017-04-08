require 'test_helper'

module Api
  module V1
    class QuizzesControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @quiz = quizzes(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:quizzes)
      end

      test "should show quiz" do
        get :show, params: {id: @quiz}, format: :json
        assert_response :success
      end


      # test "should create quiz" do
      #   assert_difference('Quiz.count', 1) do
      #     post :create, params: {quiz: cleaned_attributes(@quiz.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:quiz)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@quiz.attributes).keys.sort
      # end
      #
      # test "should update quiz" do
      #   patch :update, params: {id: @quiz.id, quiz: cleaned_attributes(@quiz.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:quiz)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@quiz.attributes).keys.sort
      # end
      #
      # test "should destroy quiz" do
      #   assert_difference('Quiz.count', -1) do
      #     delete :destroy, params: {id: @quiz.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
