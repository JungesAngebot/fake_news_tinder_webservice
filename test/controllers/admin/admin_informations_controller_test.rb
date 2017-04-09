require 'test_helper'

class Admin::InformationsControllerTest < ActionController::TestCase
  setup do
    @information = informations(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create information" do
    assert_difference('Information.count') do
      post :create, params: {information: default_params}
    end

    assert_redirected_to edit_admin_information_path(assigns(:information))
  end

  #test "should show information" do
    #get :show, params: {id: @information}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @information}
    assert_response :success
  end

  test "should update information" do
    patch :update, params: {id: @information, information: default_params}
    assert_redirected_to edit_admin_information_path(assigns(:information))
  end

  test "should destroy information" do
    assert_difference('Information.count', -1) do
      delete :destroy, params: {id: @information}
    end

    assert_redirected_to admin_informations_path
  end

  private

  def default_params
    { 
      category_id: @information.category_id, challenge_text: @information.challenge_text, correct_answer_id: @information.correct_answer_id, created_at: @information.created_at, id: @information.id, information_type_id: @information.information_type_id, result_text: @information.result_text, source_link: @information.source_link, tombstone: @information.tombstone, updated_at: @information.updated_at 
    }
  end
end
