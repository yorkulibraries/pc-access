FactoryGirl.define do
  factory :computer do
    sequence(:ip) { |n| "10.0.0.1#{n}" }
    current_username "jamesmay"
    previous_username "jeremyclarkson"
    last_ping 1.minute.ago
    last_user_activity 30.seconds.ago

    association(:location)
    image nil
    floor_id nil
    area_id nil
    
    general_usage Computer::PUBLIC_USE
  end
end
