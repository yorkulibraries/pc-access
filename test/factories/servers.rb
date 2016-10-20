FactoryGirl.define do
  factory :server do
    sequence(:hostname) { |n| "comp_#{n}.library.yorku.ca" }
    sequence(:public_ip) { |n| "130.63.180.1#{n}" }
    sequence(:local_ip) { |n| "10.0.0.1#{n}" }
    os_name "Ubuntu 14.04 LTS"
    last_ping 3.minutes.ago
    note "For me"
    administrator "LCS"
  end

end
