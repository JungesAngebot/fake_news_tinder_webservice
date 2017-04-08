require 'test_helper'

class Admin::QuizInformationsControllerTest < ActionController::TestCase
  setup do
    @quiz_information = quiz_informations(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_information" do
    assert_difference('QuizInformation.count') do
      post :create, params: {quiz_information: default_params}
    end

    assert_redirected_to edit_admin_quiz_information_path(assigns(:quiz_information))
  end

  #test "should show quiz_information" do
    #get :show, params: {id: @quiz_information}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @quiz_information}
    assert_response :success
  end

  test "should update quiz_information" do
    patch :update, params: {id: @quiz_information, quiz_information: default_params}
    assert_redirected_to edit_admin_quiz_information_path(assigns(:quiz_information))
  end

  test "should destroy quiz_information" do
    assert_difference('QuizInformation.count', -1) do
      delete :destroy, params: {id: @quiz_information}
    end

    assert_redirected_to admin_quiz_informations_path
  end

  private

  def default_params
    { 
      created_at: @quiz_information.created_at, id: @quiz_information.id, information_id: @quiz_information.information_id, quiz_id: @quiz_information.quiz_id, tombstone: @quiz_information.tombstone, updated_at: @quiz_information.updated_at 
    }
  end
end
