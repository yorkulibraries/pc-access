FactoryGirl.define do
  factory :location do
    sequence(:name) { |n| "Building ##{n}" }
    sequence(:ip_subnet) { |n| "180.2#{n}"}
  end
end
