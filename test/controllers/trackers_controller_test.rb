require 'test_helper'

class TrackersControllerTest < ActionController::TestCase

  should "have a computer in db after logon" do
    assert_difference "Computer.count", 1 do
      get :logon, username: "tester"
      c = assigns(:computer)
      assert c, "computer is present"
      assert_equal c.ip, request.remote_ip
      assert_response :success
    end
  end

  should "still have computer in db after logoff" do
    create(:computer, ip: request.remote_ip)
    
    assert_no_difference "Computer.count" do
      get :logoff
      c = assigns(:computer)
      assert c, "Computer is present"
      assert Computer.exists?(:ip => request.remote_ip)
      assert_response :success
    end

  end
end
