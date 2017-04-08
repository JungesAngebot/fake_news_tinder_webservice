require 'test_helper'

class Admin::QuizzesControllerTest < ActionController::TestCase
  setup do
    @quiz = quizzes(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quizzes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz" do
    assert_difference('Quiz.count') do
      post :create, params: {quiz: default_params}
    end

    assert_redirected_to edit_admin_quiz_path(assigns(:quiz))
  end

  #test "should show quiz" do
    #get :show, params: {id: @quiz}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @quiz}
    assert_response :success
  end

  test "should update quiz" do
    patch :update, params: {id: @quiz, quiz: default_params}
    assert_redirected_to edit_admin_quiz_path(assigns(:quiz))
  end

  test "should destroy quiz" do
    assert_difference('Quiz.count', -1) do
      delete :destroy, params: {id: @quiz}
    end

    assert_redirected_to admin_quizzes_path
  end

  private

  def default_params
    { 
      created_at: @quiz.created_at, id: @quiz.id, title: @quiz.title, tombstone: @quiz.tombstone, updated_at: @quiz.updated_at 
    }
  end
end
