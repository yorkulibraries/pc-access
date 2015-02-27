require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  
  test "index should return correct occupied count" do
    get :index, :format => 'json'
    assert_response :success
    status = JSON.parse(@response.body)
    assert_equal 2, status['occupied'].count
  end

end
