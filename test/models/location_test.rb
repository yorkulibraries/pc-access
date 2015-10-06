require 'test_helper'

class LocationTest < ActiveSupport::TestCase



  should "should create a valid Location and have a first floor" do
    location = build(:location)

    assert_difference ["Location.count", "Floor.count"], 1 do
      location.save
      assert_equal 1, location.floors.size, "Should have 1 floor by default"
    end


  end

  should "not create an invalid location" do
    assert ! build(:location, name: nil).valid?, "Name should not be blank"

    create(:location, name: "test")
    assert ! build(:location, name: "test").valid?, "Duplicate name"
  end

  should "show active locations only by default, and deleted via a scope" do
    create_list(:location, 3, deleted: true)
    create_list(:location, 2, deleted: false)

    assert_equal 2, Location.all.size, "Should be two"
    assert_equal 3, Location.deleted.size, "Should be 3"
  end

  should "ensure that location has correct number of computers" do
    @loc_one = create(:location)
    @loc_two = create(:location)

    create_list(:computer, 2, location: @loc_one)
    create_list(:computer, 1, location: @loc_two)
    assert_equal 2, @loc_one.computers.count
    assert_equal 1, @loc_two.computers.count
  end


end
