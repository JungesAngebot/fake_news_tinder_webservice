require 'test_helper'

class JwtAuthenticationTest < ActionDispatch::IntegrationTest

  setup do
    @default_allow_anonymous_users = Rails.application.config.allow_anonymous_users
    switch_anonymity_on(false)
  end

  teardown do
    Rails.application.config.allow_anonymous_users = @default_allow_anonymous_users
  end

  test 'login via jwt' do
    headers = {}
    headers['X-Api-Token'] = ENV['API_TOKEN']
    auth_dict = {'username': users(:registered_user_1).email, password: 'Password123'}
    post '/api/v1/jwt_token.json', params: auth_dict, headers: headers
    assert_response :success

    token = JSON.parse(@response.body)['token']
    assert_not_nil token

    get '/api/v1/api_authenticated_nothing', params: {}, headers: headers
    assert_response :unauthorized

    headers['Authorization'] = "Bearer #{token}"
    get '/api/v1/api_authenticated_nothing', params: {}, headers: headers
    assert_response :success
  end

  def switch_anonymity_on(turn_on)
    Rails.application.config.allow_anonymous_users = turn_on
  end

end
