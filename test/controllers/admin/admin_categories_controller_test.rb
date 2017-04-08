require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, params: {category: default_params}
    end

    assert_redirected_to edit_admin_category_path(assigns(:category))
  end

  #test "should show category" do
    #get :show, params: {id: @category}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @category}
    assert_response :success
  end

  test "should update category" do
    patch :update, params: {id: @category, category: default_params}
    assert_redirected_to edit_admin_category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, params: {id: @category}
    end

    assert_redirected_to admin_categories_path
  end

  private

  def default_params
    { 
      created_at: @category.created_at, id: @category.id, title: @category.title, tombstone: @category.tombstone, updated_at: @category.updated_at 
    }
  end
end
