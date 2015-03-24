require 'test_helper'

class TrackersControllerTest < ActionController::TestCase
  setup do
    @computer_one = computers(:one)
    @computer_two = computers(:two)
  end
  
  test "computer should exist after logon" do
    get :logon
    assert Computer.exists?(:ip => request.remote_ip)
    assert_response :success
  end
  
  test "computer should exist after logoff" do
    get :logoff
    assert Computer.exists?(:ip => request.remote_ip)
    assert_response :success
  end
  
  test "computer should be occupied after logon" do
    get :logon
    assert Computer.find_by_ip(request.remote_ip).occupied
    assert_response :success
  end
  
  test "computer should not be occupied after logoff" do
    get :logoff
    assert !Computer.find_by_ip(request.remote_ip).occupied
    assert_response :success
  end

  
end
