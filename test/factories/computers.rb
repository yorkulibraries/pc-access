FactoryGirl.define do
  factory :computer do
    sequence(:ip) { |n| "10.0.0.1#{n}" }
    current_username "jamesmay"
    previous_username "jeremyclarkson"
    last_ping 1.minute.ago
    last_keep_alive 30.seconds.ago

    association(:location)
  end
end
