require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  should "should create a valid area" do
    area = build(:area)

    assert_difference "Area.count", 1 do
      area.save
    end
  end

  should "not create an invalid area" do
    assert ! build(:area, name: nil).valid?, "Name should not be blank"
    assert ! build(:area, floor: nil).valid?, "Floor is required"

  end

  should "show active areas only by default, and deleted via a scope" do
    create_list(:area, 3, deleted: true)
    create_list(:area, 2, deleted: false)

    assert_equal 2, Area.all.size, "Should be two"
    assert_equal 3, Area.deleted.size, "Should be 3"
  end
end
