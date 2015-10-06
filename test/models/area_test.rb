require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  should "create a valid area" do
    area = build(:area)
    assert_difference "Area.count", 1 do
      area.save
    end
  end
end
