FactoryGirl.define do
  factory :server do
    sequence(:hostname) { |n| "comp_#{n}.library.yorku.ca" }
    sequence(:public_ip) { |n| "130.63.180.1#{n}" }
    sequence(:local_ip) { |n| "10.0.0.1#{n}" }
    local_hostname "Ubuntu"
    public_ip_used false
    local_ip_used false
    last_ping 3.minutes.ago
    local_used_by "For me"
    public_used_by "LCS"
  end

end
