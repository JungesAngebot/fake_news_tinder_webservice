require 'test_helper'

class Admin::InformationTypesControllerTest < ActionController::TestCase
  setup do
    @information_type = information_types(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:information_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create information_type" do
    assert_difference('InformationType.count') do
      post :create, params: {information_type: default_params}
    end

    assert_redirected_to edit_admin_information_type_path(assigns(:information_type))
  end

  #test "should show information_type" do
    #get :show, params: {id: @information_type}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @information_type}
    assert_response :success
  end

  test "should update information_type" do
    patch :update, params: {id: @information_type, information_type: default_params}
    assert_redirected_to edit_admin_information_type_path(assigns(:information_type))
  end

  test "should destroy information_type" do
    assert_difference('InformationType.count', -1) do
      delete :destroy, params: {id: @information_type}
    end

    assert_redirected_to admin_information_types_path
  end

  private

  def default_params
    { 
      created_at: @information_type.created_at, id: @information_type.id, title: @information_type.title, tombstone: @information_type.tombstone, updated_at: @information_type.updated_at 
    }
  end
end
