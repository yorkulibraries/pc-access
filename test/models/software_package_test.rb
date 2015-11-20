require 'test_helper'

class SoftwarePackageTest < ActiveSupport::TestCase
  should "should create a valid software_package" do
    software = build(:software_package)

    assert_difference "SoftwarePackage.count", 1 do
      software.save
    end
  end

  should "not create an invalid software_package" do
    assert ! build(:software_package, name: nil).valid?, "Name should not be blank"

  end
end
