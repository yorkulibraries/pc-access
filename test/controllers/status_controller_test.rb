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
    assert_equal 0, status['in_use_count']
    assert_equal 0, status['in_use'].size
    assert_equal 3, status['not_in_use_count']
    assert_equal 3, status['not_in_use'].size
  end
end
