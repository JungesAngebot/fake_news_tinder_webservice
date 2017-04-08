require 'test_helper'

module Api
  module V1
    class CategoriesControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @category = categories(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:categories)
      end

      test "should show category" do
        get :show, params: {id: @category}, format: :json
        assert_response :success
      end

      #
      # test "should create category" do
      #   assert_difference('Category.count', 1) do
      #     post :create, params: {category: cleaned_attributes(@category.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:category)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@category.attributes).keys.sort
      # end
      #
      # test "should update category" do
      #   patch :update, params: {id: @category.id, category: cleaned_attributes(@category.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:category)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@category.attributes).keys.sort
      # end
      #
      # test "should destroy category" do
      #   assert_difference('Category.count', -1) do
      #     delete :destroy, params: {id: @category.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
