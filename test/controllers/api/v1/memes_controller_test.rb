require 'test_helper'

module Api
  module V1
    class MemesControllerTest < ActionController::TestCase
      include BasicApiAuth

      setup do
        basic_api_auth(users(:registered_user_3))
        @meme = memes(:one)
      end

      test "should get index" do
        get :index, format: :json
        assert_response :success
        assert_not_nil assigns(:memes)
      end

      test "should show meme" do
        get :show, params: {id: @meme}, format: :json
        assert_response :success
      end


      # test "should create meme" do
      #   assert_difference('Meme.count', 1) do
      #     post :create, params: {meme: cleaned_attributes(@meme.attributes)}, format: :json
      #   end
      #   assert_response :success
      #   assert_not_nil assigns(:meme)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@meme.attributes).keys.sort
      # end
      #
      # test "should update meme" do
      #   patch :update, params: {id: @meme.id, meme: cleaned_attributes(@meme.attributes)}, format: :json
      #   assert_response :success
      #   assert_not_nil assigns(:meme)
      #   assert_equal cleaned_attributes(JSON.parse(@response.body)).keys.sort, cleaned_attributes(@meme.attributes).keys.sort
      # end
      #
      # test "should destroy meme" do
      #   assert_difference('Meme.count', -1) do
      #     delete :destroy, params: {id: @meme.id}, format: :json
      #   end
      #
      #   assert_response :success
      # end

    end
  end
end
