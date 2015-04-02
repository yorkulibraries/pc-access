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
  
  test "computers.current_username should not be nil after logon" do
    get :logon, {:username => "test_username"}
    assert_not_nil Computer.find_by_ip(request.remote_ip).current_username
    assert_response :success
  end
  
  test "computers.current_username should be nil after logoff" do
    get :logoff, {:username => "test_username"}
    assert_nil Computer.find_by_ip(request.remote_ip).current_username
    assert_response :success
  end

  test "computers.last_ping should not be nil after logon" do
    get :logon
    assert_not_nil Computer.find_by_ip(request.remote_ip).last_ping
    assert_response :success
  end
  
  test "computers.last_ping should be nil after logoff" do
    get :logoff
    assert_nil Computer.find_by_ip(request.remote_ip).last_ping
    assert_response :success
  end
end
