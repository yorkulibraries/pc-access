require 'test_helper'

class StatusControllerTest < ActionController::TestCase

  test "index.json should return correct data" do
    create_list(:computer, 3)
    create_list(:computer, 2, current_username: nil)

    get :index, :format => :json
    assert_response :success
    status = JSON.parse(@response.body)
    assert_equal 3, status['in_use'].size
    assert_equal 2, status['not_in_use'].size
  end
end
