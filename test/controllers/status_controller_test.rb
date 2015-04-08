require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  setup do
    @computer_one = computers(:pc_one)
    @computer_two = computers(:pc_two)
  end
  
  test "index.json should return correct data" do
    get :index, :format => :json
    assert_response :success
    status = JSON.parse(@response.body)
    assert_equal 1, status['in_use_count']
    assert_equal 1, status['in_use'].size
    assert_equal 2, status['not_in_use_count']
    assert_equal 2, status['not_in_use'].size
    assert_equal @computer_two.ip, status['in_use'].first['ip']
  end
end
