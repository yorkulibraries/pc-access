require 'test_helper'

class TrackersControllerTest < ActionController::TestCase

  should "have a computer in db after logon if useing ip as key" do
    assert_difference "Computer.count", 1 do
      get :logon, username: "tester"
      c = assigns(:computer)
      assert c, "computer is present"
      assert_equal c.ip, request.remote_ip
      assert_response :success
    end
  end


  should "have a computer in db after logon if using hostname as key" do
    assert_difference "Computer.count", 1 do
      hostname = "somethi.something.ca"
      get :logon, username: "tester", hostname: hostname
      c = assigns(:computer)
      assert c, "computer is present"
      assert_equal c.hostname, hostname
      assert_equal c.ip, request.remote_ip
      assert_response :success
    end
  end

  should "LOGON: update hostname if found by ip and hostname is nil" do
    c = create(:computer, hostname: nil, ip: request.remote_ip)

    assert_no_difference "Computer.count" do
      hostname = "something"
      get :logon, username: "tester", hostname: hostname
      c = assigns(:computer)
      assert_equal c.hostname, hostname
    end
  end

  should "LOGOFF: update hostname if found by ip and hostname is nil" do
    c = create(:computer, hostname: nil, ip: request.remote_ip)

    assert_no_difference "Computer.count" do
      hostname = "something"
      get :logoff, username: "tester", hostname: hostname
      c = assigns(:computer)
      assert_equal c.hostname, hostname
    end
  end

  should "PING: update hostname if found by ip and hostname is nil" do
    c = create(:computer, hostname: nil, ip: request.remote_ip)

    assert_no_difference "Computer.count" do
      hostname = "something"
      get :ping, username: "tester", hostname: hostname
      c = assigns(:computer)
      assert_equal c.hostname, hostname
    end
  end


  should "LOGON: use existing computer if found by hostname" do
    h = "host"
    c = create(:computer, hostname: h)

    assert_no_difference "Computer.count" do
      get :logon, username: "tester", hostname: h
    end
  end

  should "LOGOFF: use existing computer if found by hostname" do
    h = "host"
    c = create(:computer, hostname: h)

    assert_no_difference "Computer.count" do
      get :logoff, username: "tester", hostname: h
    end
  end

  should "PING: use existing computer if found by hostname" do
    h = "host"
    c = create(:computer, hostname: h)

    assert_no_difference "Computer.count" do
      get :ping, username: "tester", hostname: h
    end
  end

  should "LOGON: create a new computer if hostname is present but was not found" do
    assert_difference "Computer.count", 1 do
      hostname = "somethi.something.ca"
      get :logon, username: "tester", hostname: hostname
    end
  end

  should "LOGOFF: create a new compute if hostname is present but was not found" do
    assert_difference "Computer.count", 1 do
      h = "different_hostname"
      get :logoff, username: "tester", hostname: h
    end
  end

  should "PING: create a new compute if hostname is present but was not found" do
    assert_difference "Computer.count", 1 do
      h = "different_hostname"
      get :ping, username: "tester", hostname: h
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

  should "still have computer in db after logoff, using hostname" do
    computer = create(:computer, ip: request.remote_ip, hostname: "tester")

    assert_no_difference "Computer.count" do
      get :logoff, hostname: computer.hostname
      c = assigns(:computer)
      assert c, "Computer is present"
      assert Computer.exists?(:hostname => computer.hostname)
      assert_response :success
    end

  end


  should "record activiy log entry on each action" do
    assert_difference "ComputerActivityLog.count", 3 do
      get :ping # After initial one, it should have a register and a PING
      get :logon, username: "tester"
      get :logoff

    end
  end

end
