require 'test_helper'

class TrackersControllerTest < ActionController::TestCase
  setup do
    @tracker = trackers(:one)
  end
  
  test "tracker should exist after logon" do
    get :logon
    assert Tracker.exists?(:ip => request.remote_ip)
    assert_equal 3, Tracker.count
    assert_response :success
  end
  
  test "multiple logon should create one tracker" do
    get :logon
    post :logon
    put :logon
    patch :logon
    assert Tracker.exists?(:ip => request.remote_ip)
    assert_equal 1, Tracker.where(:ip => request.remote_ip).count
    assert_equal 3, Tracker.count
    assert_response :success
  end
  
  test "tracker should not exist after logoff" do
    get :logoff
    assert_not Tracker.exists?(:ip => request.remote_ip)
    assert_equal 2, Tracker.count
    assert_response :success
  end

end
