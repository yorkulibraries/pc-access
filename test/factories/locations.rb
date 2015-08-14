FactoryGirl.define do
  factory :location do
    sequence(:name) { |n| "Building ##{n}" }
  end
end
