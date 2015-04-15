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
  
  test "ping_timed_out should return correct record" do
    @computer_one.last_ping = DateTime.now
    @computer_one.save
    
    @computer_two.last_ping = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @ping_timed_out = Computer.ping_timed_out
    assert_equal 1, @ping_timed_out.size
    assert_equal @computer_two, @ping_timed_out.first
  end
  
  test "actively_pinging should return correct record" do
    @computer_one.last_ping = DateTime.now
    @computer_one.save
    
    @computer_two.last_ping = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @actively_pinging = Computer.actively_pinging
    assert_equal 1, @actively_pinging.size
    assert_equal @computer_one, @actively_pinging.first
  end
  
  test "keep_alive_timed_out should return correct record" do
    @computer_one.last_keep_alive = DateTime.now
    @computer_one.save
    
    @computer_two.last_keep_alive = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @keep_alive_timed_out = Computer.keep_alive_timed_out
    assert_equal 1, @keep_alive_timed_out.size
    assert_equal @computer_two, @keep_alive_timed_out.first
  end
  
  test "actively_keep_alive should return correct record" do
    @computer_one.last_keep_alive = DateTime.now
    @computer_one.save
    
    @computer_two.last_keep_alive = DateTime.now - Computer.config.keep_alive_interval
    @computer_two.save
    
    @actively_keep_alive = Computer.actively_keep_alive
    assert_equal 1, @actively_keep_alive.size
    assert_equal @computer_one, @actively_keep_alive.first
  end
  
  test "logon should set correct states" do
    username = 'test'
    @computer_one.logon(username)
    @computer_one.save
    
    after = Computer.find(@computer_one.id)
    
    assert after.is_in_use
    assert_equal username, after.current_username
    assert_not_nil after.last_ping
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
        
    assert_equal 2, Computer.in_use.keep_alive_timed_out.count
    
    Computer.free_inactive_computers
    
    assert_equal 0, Computer.in_use.keep_alive_timed_out.count, "Number of inactive should be 0"
    assert_equal in_use_count - 2, Computer.in_use.count, "Number of in-use computers should be 2 less"
    assert_equal not_in_use_count + 2, Computer.not_in_use.count, "Number of not-in-use computers should be 2 more"
    assert_equal all_computers_count, Computer.count, "Total number of computers should not change"
    
  end
  
end
