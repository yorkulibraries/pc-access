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

  should "attach computers based on ip list" do
    image1 = create(:image)
    image2 = create(:image)
    attach_to_1 = create_list(:computer, 4)
    attach_to_2 = create_list(:computer, 5)

    image1.attach_computers(attach_to_1.collect { |c| c.ip }.join("\n"))

    assert_equal 4, image1.computers.count, "Should be 4 computers in this image"

    image2.attach_computers(attach_to_2.collect { |c| c.ip }.join("\n"))

    assert_equal 5, image2.computers.count, "Should be 5 computers in this image"
  end

  should "remove existing attached computers and add new ones" do
    image = create(:image)
    old_list = create_list(:computer, 2)
    new_list = create_list(:computer, 3)

    image.attach_computers(old_list.collect { |c| c.ip }.join("\n"))
    assert_equal 2, image.computers.count, "Two computers"


    image.attach_computers(new_list.collect { |c| c.ip }.join("\n"))
    assert_equal 3, image.computers.count, "Three computers"
    assert_equal new_list.first.id, image.computers.first.id, "New List Computer should match"

  end
end
