require 'test_helper'

class Admin::FmBaseControllerTest < ActionController::TestCase
  setup do
  end

  test 'should redirect to authenticate' do
    get :admin_authenticated_nothing
    assert_redirected_to '/users/sign_in'
  end

  test 'should be authenticated by credentials' do
    sign_in users(:admin), scope: :user
    get :admin_authenticated_nothing
    assert_response :success
  end
end
