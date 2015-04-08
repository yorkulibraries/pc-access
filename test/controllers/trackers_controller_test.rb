require 'test_helper'

class TrackersControllerTest < ActionController::TestCase
  setup do
    @computer_one = computers(:pc_one)
    @computer_two = computers(:pc_two)
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
end
