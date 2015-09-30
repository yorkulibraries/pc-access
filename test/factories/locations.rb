FactoryGirl.define do
  factory :location do
    sequence(:name) { |n| "Building ##{n}" }
    sequence(:ip_subnet) { |n| "130.63.1#{n}"}
    deleted false
  end
end
