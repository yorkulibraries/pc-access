require 'test_helper'

class FloorTest < ActiveSupport::TestCase

  should "should create a valid floor" do
    floor = build(:floor)

    assert_difference "Floor.count", 1 do
      floor.save
    end
  end

  should "not create an invalid floor" do
    assert ! build(:floor, name: nil).valid?, "Name should not be blank"

    assert ! build(:floor, position: nil).valid?, "Position is required"
    assert ! build(:floor, location: nil).valid?, "Location is required"
  end

  should "show active floors only by default, and deleted via a scope" do
    create_list(:floor, 3, deleted: true)
    create_list(:floor, 2, deleted: false)

    assert_equal 2, Floor.all.size, "Should be two"
    assert_equal 3, Floor.deleted.size, "Should be 3"
  end

end
