require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get quiz" do
    get quiz_quiz_url
    assert_response :success
  end

end
