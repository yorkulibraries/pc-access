require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  setup do
    @computer_one = computers(:one)
    @computer_two = computers(:two)
  end
  
  test "in_use should return correct data" do
    @in_use = Computer.in_use
    assert_equal 1, @in_use.count
    assert_equal @computer_two, @in_use.first
    assert_equal @computer_two.current_username, @in_use.first.current_username
  end
  
  test "not_in_use should return correct data" do
    @not_in_use = Computer.not_in_use
    assert_equal 1, @not_in_use.count
    assert_equal @computer_one.ip, @not_in_use.first.ip
    assert_nil @not_in_use.first.current_username
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
  end
  
  test "current_username should be nil after logoff" do
    @computer_one.logoff
    assert_nil @computer_one.current_username
  end

  test "last_ping should not be nil after logon" do
    @computer_one.logon('test_user1')
    assert_not_nil @computer_one.last_ping
  end
  
  test "last_ping should be nil after logoff" do
    @computer_one.logoff
    assert_nil @computer_one.last_ping
  end
end
