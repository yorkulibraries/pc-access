require 'test_helper'

class ComputerActivityLogTest < ActiveSupport::TestCase

  should "should create a valid ActivityLog" do
    log = build(:computer_activity_log)

    assert_difference "ComputerActivityLog.count", 1 do
      log.save
    end
  end

  should "not create an invalid ActivityLog" do
    assert ! build(:computer_activity_log, computer_id: nil).valid?, "Computer ID should not be blank"
    assert ! build(:computer_activity_log, ip: nil).valid?, "IP is required"

    c = create(:computer)
    assert_equal c.ip, c.activity_entries.first.ip, "IPs should match"

  end
end
