require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  setup do
    @computer_one = computers(:pc_one)
    @computer_two = computers(:pc_two)
    @computer_three = computers(:pc_three)
  end
  
  test "in_use should return correct data" do
    assert_equal 3, Computer.count
    assert_equal 0, Computer.in_use.count
    
    @computer_one.logon('test1')
    @computer_one.save
    
    assert_equal 1, Computer.in_use.count
    assert_equal @computer_one, Computer.in_use.first
  end
  
  test "not_in_use should return correct data" do
    assert_equal 3, Computer.count
    assert_equal 3, Computer.not_in_use.count
    
    @computer_one.logon('test1')
    @computer_one.save
    
    assert_equal 2, Computer.not_in_use.count
    assert_equal @computer_two, Computer.not_in_use.order('ip').first 
    assert_equal @computer_three, Computer.not_in_use.order('ip').last 
  end
  
  test "not_pinging should return correct record" do
    @computer_one.last_ping = DateTime.now
    @computer_one.save
    
    @computer_two.last_ping = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @not_pinging = Computer.not_pinging
    assert_equal 1, @not_pinging.size
    assert_equal @computer_two, @not_pinging.first
  end
  
  test "never_pingi should return correct record" do
    @computer_two.ping
    @computer_two.save
    
    @computer_three.ping
    @computer_three.save
    
    @never_ping = Computer.never_ping
    assert_equal 1, @never_ping.size
    assert_equal @computer_one, @never_ping.first
  end
  
  test "pinging should return correct record" do
    @computer_one.last_ping = DateTime.now
    @computer_one.save
    
    @computer_two.last_ping = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @pinging = Computer.pinging
    assert_equal 1, @pinging.size
    assert_equal @computer_one, @pinging.first
  end
  
  test "not_keeping_alive should return correct record" do
    @computer_one.last_keep_alive = DateTime.now
    @computer_one.save
    
    @computer_two.last_keep_alive = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @not_keeping_alive = Computer.not_keeping_alive
    assert_equal 1, @not_keeping_alive.size
    assert_equal @computer_two, @not_keeping_alive.first
  end
  
  test "keeping_alive should return correct record" do
    @computer_one.last_keep_alive = DateTime.now
    @computer_one.save
    
    @computer_two.last_keep_alive = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @keeping_alive = Computer.keeping_alive
    assert_equal 1, @keeping_alive.size
    assert_equal @computer_one, @keeping_alive.first
  end
  
  test "logon should set correct states" do
    username = 'test'
    @computer_one.logon(username)
    @computer_one.save
    
    after = Computer.find(@computer_one.id)
    
    assert after.is_in_use
    assert_equal username, after.current_username
    assert_not_nil after.last_keep_alive
  end
  
  test "logoff should set correct states" do
    username = 'test'
    @computer_one.logon(username)
    @computer_one.save
    
    @computer_one = Computer.find(@computer_one.id)
    @computer_one.logoff
    @computer_one.save
    
    after = Computer.find(@computer_one.id)
    
    assert_nil after.current_username
    assert_not after.is_in_use
    assert_equal username, after.previous_username
  end
  
  test "logoff should not change previous_username if current_username is nil" do
    previous_username = 'test_previous_username'
    @computer_one.previous_username = previous_username
    @computer_one.save
    
    @computer_one = Computer.find(@computer_one.id)
    assert_nil @computer_one.current_username
    assert_equal previous_username, @computer_one.previous_username

    @computer_one.logoff
    @computer_one.save
    
    after = Computer.find(@computer_one.id)
    
    assert_nil after.current_username
    assert_equal previous_username, after.previous_username
  end
  
  test "free_inactive_computers should free up inactive computers" do
    @computer_one.logon('test1')
    @computer_one.last_keep_alive = DateTime.now
    @computer_one.save
    
    @computer_two.logon('test2')
    @computer_two.last_keep_alive = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    all_computers_count = Computer.count
    in_use_count = Computer.in_use.count
    not_in_use_count = Computer.not_in_use.count 
    
    assert_equal 3, all_computers_count
    assert_equal 2, in_use_count
    assert 1, not_in_use_count
    
    sleep 1.seconds
        
    assert_equal 2, Computer.in_use.not_keeping_alive.count
    
    Computer.free_inactive_computers
    
    assert_equal 0, Computer.in_use.not_keeping_alive.count, "Number of inactive should be 0"
    assert_equal in_use_count - 2, Computer.in_use.count, "Number of in-use computers should be 2 less"
    assert_equal not_in_use_count + 2, Computer.not_in_use.count, "Number of not-in-use computers should be 2 more"
    assert_equal all_computers_count, Computer.count, "Total number of computers should not change"
    
  end
  
  test "validate IP address" do
    @computer_one.ip = nil
    assert_not @computer_one.valid?
    
    @computer_one.ip = '256.0.0.0'
    assert_not @computer_one.valid?
    
    @computer_one.ip = '1.0.0.256'
    assert_not @computer_one.valid?
    
    @computer_one.ip = '127.0.0.1'
    assert @computer_one.valid?
  end
  
  test "validate IP uniqueness" do
    @computer_one.ip = @computer_two.ip
    assert_not @computer_one.valid?
  end
end
