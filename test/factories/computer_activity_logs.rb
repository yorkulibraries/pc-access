FactoryGirl.define do
  factory :computer_activity_log do
    association(:computer)
    ip { computer.ip }
    activity_date { DateTime.now }
    action ComputerActivityLog::ACTION_PING
    sequence(:username) { |n| "username_#{n}" }
  end

end
