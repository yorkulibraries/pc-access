require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  setup do
    @computer_one = computers(:pc_one)
    @computer_two = computers(:pc_two)
    @computer_three = computers(:pc_three)
  end
  
  test "in_use should return correct data" do
    @in_use = Computer.in_use
    assert_equal 1, @in_use.count
    assert_equal @computer_two, @in_use.first
    assert_equal @computer_two.current_username, @in_use.first.current_username
    assert @in_use.first.is_in_use
  end
  
  test "not_in_use should return correct data" do
    @not_in_use = Computer.not_in_use
    assert_equal 2, @not_in_use.count
    @not_in_use.each do |computer|
      assert_not computer.is_in_use
      assert_nil computer.current_username
    end
  end
  
  test "powered_off should return correct data" do
    @powered_off = Computer.powered_off
    @powered_off.each do |computer|
      assert computer.is_powered_off
      assert_not computer.is_in_use
      assert_nil computer.current_username
    end
  end
  
  test "last_ping_more_than_x_time_ago should return correct record" do
    @computer_one.last_ping = DateTime.now - 14.minutes
    @computer_one.save
    @computer_two.last_ping = DateTime.now - 15.minutes
    @computer_two.save
    
    @last_ping_more_than_15_minutes_ago = Computer.last_ping_more_than_x_time_ago(15.minutes)
    assert_equal 1, @last_ping_more_than_15_minutes_ago.size
    assert_equal @computer_two, @last_ping_more_than_15_minutes_ago.first
  end
  
  test "current_username should be correctly updated after logon" do
    @computer_one.logon('test_user1')
    assert_equal 'test_user1', @computer_one.current_username
    @computer_two.logon('test_user2')
    assert_equal 'test_user2', @computer_two.current_username
  end
  
  test "current_username should be nil after logoff" do
    @computer_one.logoff
    assert_nil @computer_one.current_username
    @computer_two.logoff
    assert_nil @computer_two.current_username
  end
  
  test "is_in_use should be false after logoff" do
    @computer_one.logoff
    assert_not @computer_one.is_in_use
    @computer_two.logoff
    assert_not @computer_two.is_in_use
  end
  
  test "is_in_use should be true after logon" do
    @computer_one.logon('test_user1')
    assert @computer_one.is_in_use
    @computer_two.logon('test_user2')
    assert @computer_two.is_in_use
  end

  test "last_ping should not be nil after logon" do
    @computer_one.logon('test_user1')
    assert_not_nil @computer_one.last_ping
    @computer_two.logon('test_user2')
    assert_not_nil @computer_two.last_ping
  end
  
  test "last_ping should be nil after logoff" do
    @computer_one.logoff
    assert_nil @computer_one.last_ping
    @computer_two.logoff
    assert_nil @computer_two.last_ping
  end
  
  test "logoff should save current_username to previous_username if it is not nil" do
    current_username = @computer_two.current_username
    assert_not_nil current_username
    assert_nil @computer_two.previous_username
    @computer_two.logoff
    assert_equal current_username, @computer_two.previous_username
  end
  
  test "logoff should not change previous_username if current_username is nil" do
    previous_username = @computer_one.previous_username
    assert_nil @computer_one.current_username
    @computer_one.logoff
    assert_equal previous_username, @computer_one.previous_username
  end
  
  test "logon_time should not change if same username logon multiple times" do
    username = 'test_user1'
    @computer_one.logon(username)
    assert_not_nil @computer_one.logon_time
    logon_time = @computer_one.logon_time
    
    @computer_one.logon(username)
    @computer_one.logon(username)
    @computer_one.logon(username)
    assert_equal logon_time, @computer_one.logon_time
  end
  
  test "power_on immediately after logon should not change logon states" do
    username = 'test'
    @computer_one.logon(username)
    logon_time = @computer_one.logon_time
    assert @computer_one.is_in_use
    @computer_one.power_on
    assert @computer_one.is_in_use
    assert_equal username, @computer_one.current_username
    assert_equal logon_time, @computer_one.logon_time
  end

  test "power_on #{Computer.config.max_delayed_power_on_time} seconds after logon should change to not-in-use state" do
    username = 'test'
    @computer_one.logon(username)
    logon_time = @computer_one.logon_time
    assert @computer_one.is_in_use
    
    sleep(Computer.config.max_delayed_power_on_time)
    
    @computer_one.power_on
    assert_not @computer_one.is_in_use
    assert_nil @computer_one.current_username
    assert_nil @computer_one.logon_time
  end
end
