require 'test_helper'

class BasicTest < ActionDispatch::IntegrationTest

  test 'root path without error' do
    get '/'
    success = 200 == @response.response_code
    found = 302 == @response.response_code
    assert success || found
  end

  test 'users sign_in with login template' do
    get '/users/sign_in'
    assert_response :success
    assert_template 'login'
  end

  test 'login working' do
    registered_user = users(:registered_user_1)
    post '/users/sign_in', params: {user: { email: registered_user.email, password: 'Password123' }}
    assert_response :redirect
  end

  test 'login fails with wrong email' do
    post '/users/sign_in', params: {user: { email: 'a@a.de', password: 'Password123' }}
    # redirect would be successful login
    assert_response :success
  end

  test 'login fails with wrong password' do
    registered_user = users(:registered_user_1)
    post '/users/sign_in', params: {user: { email: registered_user.email, password: 'Password12' }}
    # redirect would be successful login
    assert_response :success
  end

end
