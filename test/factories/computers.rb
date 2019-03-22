FactoryGirl.define do
  factory :computer do
    sequence(:ip){ |n| IPAddr.new(n, Socket::AF_INET).to_s }  #{ |n| "10.#{rand(45..99)}.#{rand(1..40)}.1#{n}" }
    current_username "jamesmay"
    previous_username "jeremyclarkson"
    last_ping 1.minute.ago
    last_user_activity 30.seconds.ago

    hostname nil

    association(:location)
    image nil
    floor_id nil
    area_id nil

    general_usage Computer::PUBLIC_USE

  end
end
