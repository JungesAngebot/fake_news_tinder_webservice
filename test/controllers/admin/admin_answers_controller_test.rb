require 'test_helper'

class Admin::AnswersControllerTest < ActionController::TestCase
  setup do
    @answer = answers(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer" do
    assert_difference('Answer.count') do
      post :create, params: {answer: default_params}
    end

    assert_redirected_to edit_admin_answer_path(assigns(:answer))
  end

  #test "should show answer" do
    #get :show, params: {id: @answer}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @answer}
    assert_response :success
  end

  test "should update answer" do
    patch :update, params: {id: @answer, answer: default_params}
    assert_redirected_to edit_admin_answer_path(assigns(:answer))
  end

  test "should destroy answer" do
    assert_difference('Answer.count', -1) do
      delete :destroy, params: {id: @answer}
    end

    assert_redirected_to admin_answers_path
  end

  private

  def default_params
    { 
      created_at: @answer.created_at, id: @answer.id, information_type_id: @answer.information_type_id, text: @answer.text, tombstone: @answer.tombstone, updated_at: @answer.updated_at 
    }
  end
end
