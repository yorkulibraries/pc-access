require 'test_helper'

class TrackersControllerTest < ActionController::TestCase
  setup do
    @tracker = trackers(:one)
  end
  
  test "logon should create tracker" do
    get :logon
    assert Tracker.exists?(:ip => request.remote_ip)
    assert_response :success
  end
  
  test "multiple logon should create 1 tracker" do
    get :logon
    post :logon
    put :logon
    patch :logon
    assert Tracker.exists?(:ip => request.remote_ip)
    assert_equal 1, Tracker.where(:ip => request.remote_ip).count
    assert_response :success
  end
  
  test "logoff should destroy tracker" do
    get :logoff
    assert_not Tracker.exists?(:ip => request.remote_ip)
    assert_response :success
  end
end
