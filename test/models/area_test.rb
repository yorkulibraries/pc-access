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

  should "attach computers based on ip list" do
    area51 = create(:area)
    area52 = create(:area)
    attach_to_51 = create_list(:computer, 4)
    attach_to_52 = create_list(:computer, 5)

    area51.attach_computers(attach_to_51.collect { |c| c.ip }.join("\n"))
    area52.attach_computers(attach_to_52.collect { |c| c.ip }.join("\n"))

    assert_equal 4, area51.computers.size, "Should be 4 computers"
    assert_equal 4, area51.location.computers.size, "Should be 4 computers"
    assert_equal 4, area51.floor.computers.size, "Should be 4 computers"

    assert_equal 5, area52.computers.size, "Should be 5 computers"
    assert_equal 5, area52.location.computers.size, "Should be 5 computers"
    assert_equal 5, area52.floor.computers.size, "Should be 5 computers"

  end
  
end
