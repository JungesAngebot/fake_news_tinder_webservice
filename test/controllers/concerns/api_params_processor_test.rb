require 'test_helper'
class ApiParamsProcessorTest < ActionDispatch::IntegrationTest

  add_rules_block = Proc.new do
    get 'api_params_processor_tests' => 'api_params_processor_test#index'
    post 'api_params_processor_tests' => 'api_params_processor_test#create'
  end
  Rails.application.routes.send(:eval_block, add_rules_block)

  # Rails.application.routes.routes.each do |route|
  #   pp route.path.spec.to_s
  # end

  test 'users available' do
    get '/api_params_processor_tests.json'
    assert_response :success
    assert_not_nil get_users_from_json(@response.body)
  end

  test 'load fresh' do
    get '/api_params_processor_tests.json'
    assert get_users_from_json(@response.body).count == User.unscoped.where('email LIKE "%api-params%"').count
  end

  test 'load fresh with limit' do
    [1, 2, 3, 4].each do |limit|
      offset = 0
      users = []
      get "/api_params_processor_tests.json?limit=#{limit}&offset=#{offset}"
      users[0] = get_users_from_json(@response.body)
      assert_equal users[0].count, limit

      total_count = @response.headers['X-Elements-Total'].to_i
      offset += limit

      while offset < total_count
        get "/api_params_processor_tests.json?limit=#{limit}&offset=#{offset}"
        users[offset / limit] = get_users_from_json(@response.body)
        if offset + limit > total_count
          assert users[offset / limit].count <= limit
        else
          assert_equal users[offset / limit].count, limit
        end
        offset += limit
      end
    end
  end

  test 'last_sync_ts parameter' do
    [1, 2, 3].each do |offset|
      oldest_user = User.unscoped.where('email LIKE "%api-params%"').order(:updated_at).first
      last_synced_ts_parameter = oldest_user.updated_at.to_i + offset

      get "/api_params_processor_tests.json?limit=#{100}&offset=#{0}", headers: {'X-Elements-From' => last_synced_ts_parameter}
      users = get_users_from_json(@response.body)
      users_with_older_ts_count = User.unscoped.where('email LIKE "%api-params%"').where('updated_at <= ?', Time.at(last_synced_ts_parameter).to_datetime).count
      all_users_count = User.unscoped.where('email LIKE "%api-params%"').count
      assert_equal users.count, all_users_count - users_with_older_ts_count
      assert_equal @response.headers['X-Elements-Total'].to_i, all_users_count - users_with_older_ts_count
    end
  end

  test 'until parameter' do
    [1, 2, 3].each do |offset|
      oldest_user = User.unscoped.where('email LIKE "%api-params%"').order(:updated_at).first
      new_since_parameter = oldest_user.updated_at.to_i

      get "/api_params_processor_tests.json?limit=#{offset}&offset=#{0}", headers: {'X-Elements-From' => new_since_parameter}
      next_since = @response.headers['X-Elements-Last-Updated'].to_i
      total_count = @response.headers['X-Elements-Total'].to_i
      offset.times do
        assert_difference('User.unscoped.where(\'email LIKE "%api-params%"\').count') do
          post '/api_params_processor_tests.json', params: {user: {email: "user_added#{SecureRandom.hex}@api-params.de", password: 'Password123'}}
          assert_response :success
        end
      end
      get "/api_params_processor_tests.json?limit=#{offset}&offset=#{0 +offset}", headers: {'X-Elements-From' => new_since_parameter, 'X-Elements-Until' => next_since}
      assert_equal @response.headers['X-Elements-Last-Updated'].to_i, next_since
      assert_equal @response.headers['X-Elements-Total'].to_i, total_count

      # clear created data
      User.unscoped.where('email LIKE "%user_added%"').delete_all
    end
  end


  private

    def get_users_from_json(json)
      JSON.parse(json)
    end

end

class ApiParamsProcessorTestController < ApplicationController
  include ApiParamsProcessor

  def index
    # announce_klasses_for_use(User.where('email LIKE "%api-params%"'))
    @users = process_api_params(User.where('email LIKE "%api-params%"'))
    render :template => 'users/index', format: :json
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :template => 'users/show', format: :json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end