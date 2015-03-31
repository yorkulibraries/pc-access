require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  setup do
    @computer_one = computers(:one)
    @computer_two = computers(:two)
  end
  
  test "index.json should return correct data" do
    get :index, :format => :json
    assert_response :success
    status = JSON.parse(@response.body)
    assert_equal 1, status['occupied_count']
    assert_equal 1, status['occupied'].size
    assert_equal 1, status['available_count']
    assert_equal 1, status['available'].size
    assert_equal @computer_one.ip, status['available'][0]['ip']
    assert_nil status['available'][0]['current_username']
    assert_equal @computer_two.ip, status['occupied'][0]['ip']
    assert_not_nil status['occupied'][0]['current_username']
  end
end
