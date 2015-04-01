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
end
