require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @loc_one = locations(:loc_one)
    @loc_two = locations(:loc_two)
  end
  
  test "location has correct number of computers" do
    assert_equal 2, @loc_one.computers.count
    assert_equal 1, @loc_two.computers.count
  end
end
