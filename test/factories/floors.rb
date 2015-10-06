FactoryGirl.define do
  factory :floor do
    sequence(:name)  { |n| "Floor ##{n}" }
    position 1
    deleted false
    map nil
    association :location
  end

end
