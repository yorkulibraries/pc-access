FactoryGirl.define do
  factory :location do
    sequence(:name) { |n| "Building ##{n}" }
    address nil
    ip_subnets nil
    deleted false    
  end
end
