require 'test_helper'

module Api
  module V1
    class AnswerGivensControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @answer_given = answer_givens(:one)
      end
      #
      # test "should get index" do
      #   get :index, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:answer_givens)
      # end
      #
      # test "should show answer_given" do
      #   get :show, params: {id: @answer_given}, format: :json
      #   assert_response :success
      # end


      test "should create answer_given" do
        assert_difference('AnswerGiven.count', 1) do
          post :create, params: {answer_given: cleaned_attributes(@answer_given.attributes)}, format: :json
        end
        assert_response :success
        assert_not_nil assigns(:answer_given)
        assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@answer_given.attributes).keys.sort
      end

      # test "should update answer_given" do
      #   patch :update, params: {id: @answer_given.id, answer_given: cleaned_attributes(@answer_given.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:answer_given)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@answer_given.attributes).keys.sort
      # end
      #
      # test "should destroy answer_given" do
      #   assert_difference('AnswerGiven.count', -1) do
      #     delete :destroy, params: {id: @answer_given.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
