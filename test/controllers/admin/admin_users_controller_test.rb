require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    user_default_param = default_params
    user_default_param[:email] = 'new_user@example.org'
    user_default_param[:password] = ENV['DEFAULT_PASSWORD']
    user_default_param[:password_confirmation] = ENV['DEFAULT_PASSWORD']
    assert_difference('User.count') do
      post :create, params: {user: user_default_param}
    end

    assert_redirected_to edit_admin_user_path(assigns(:user))
  end

  #test "should show user" do
    #get :show, id: @user
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @user}
    assert_response :success
  end

  test "should update user" do
    patch :update, params: {id: @user, user: default_params}
    assert_redirected_to edit_admin_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, params: {id: @user}
    end

    assert_redirected_to admin_users_path
  end

  private

  def default_params
    { 
      admin: @user.admin, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, super_admin: @user.super_admin
    }
  end
end
