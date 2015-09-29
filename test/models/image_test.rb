require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  should "should create a valid Image" do
    image = build(:image)

    assert_difference "Image.count", 1 do
      image.save
    end
  end

  should "not create an invalid image" do
    assert ! build(:image, name: nil).valid?, "Name should not be blank"

    assert ! build(:image, os_name: nil).valid?, "IP Subnet is required"
    assert ! build(:image, os_version: nil).valid?, "IP Subnet is required"

    create(:image, name: "test")
    assert ! build(:image, name: "test").valid?, "Duplicate name"
  end

  should "show active images only by default, and deleted via a scope" do
    create_list(:image, 3, deleted: true)
    create_list(:image, 2, deleted: false)

    assert_equal 2, Image.all.size, "Should be two"
    assert_equal 3, Image.deleted.size, "Should be 3"
  end
end
