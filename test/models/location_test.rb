require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @loc_one = create(:location)
    @loc_two = create(:location)
  end

  test "location has correct number of computers" do
    create_list(:computer, 2, location: @loc_one)
    create_list(:computer, 1, location: @loc_two)
    assert_equal 2, @loc_one.computers.count
    assert_equal 1, @loc_two.computers.count
  end
end
