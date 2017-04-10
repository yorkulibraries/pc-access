require 'test_helper'

class StatusControllerTest < ActionController::TestCase

  should "return correct data" do
    create_list(:computer, 3)
    create_list(:computer, 2, current_username: nil)

    get :index, format: :json
    assert_response :success
    locations = JSON.parse(@response.body)
    assert_equal 5, locations.size
  
  end

  should "retrun correct data based on status" do
    @before_interval = (Computer::STAY_ALIVE_INTERVAL - 5.minute).ago
    @after_interval =  (Computer::STAY_ALIVE_INTERVAL + 5.minutes).ago

    create_list(:computer, 2, last_user_activity: @after_interval ) # not keeping alive
    create_list(:computer, 4, last_user_activity: @before_interval) # keeping alive
    create_list(:computer, 3, last_user_activity: nil) # never kept alive

    get :by_status, status: "not_staying_active"
    computers = assigns(:computers)
    assert_equal 2, computers.count, "Not Keeping Alive Should be 2"

    get :by_status, status: "staying_active"
    computers = assigns(:computers)
    assert_equal 4, computers.count, "should be 4"

    get :by_status, status: "never_used"
    computers = assigns(:computers)
    assert_equal 3, computers.count, "should be 3"
  end

end
