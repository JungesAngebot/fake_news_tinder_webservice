require 'test_helper'

class Admin::MemesControllerTest < ActionController::TestCase
  setup do
    @meme = memes(:one)
    @user = users(:admin)
    sign_in @user, scope: :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meme" do
    assert_difference('Meme.count') do
      post :create, params: {meme: default_params}
    end

    assert_redirected_to edit_admin_meme_path(assigns(:meme))
  end

  #test "should show meme" do
    #get :show, params: {id: @meme}
    #assert_response :success
  #end

  test "should get edit" do
    get :edit, params: {id: @meme}
    assert_response :success
  end

  test "should update meme" do
    patch :update, params: {id: @meme, meme: default_params}
    assert_redirected_to edit_admin_meme_path(assigns(:meme))
  end

  test "should destroy meme" do
    assert_difference('Meme.count', -1) do
      delete :destroy, params: {id: @meme}
    end

    assert_redirected_to admin_memes_path
  end

  private

  def default_params
    { 
      category_id: @meme.category_id, created_at: @meme.created_at, id: @meme.id, image_url: @meme.image_url, max_correct_excluding: @meme.max_correct_excluding, min_correct_including: @meme.min_correct_including, tombstone: @meme.tombstone, updated_at: @meme.updated_at 
    }
  end
end
