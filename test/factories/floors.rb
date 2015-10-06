FactoryGirl.define do
  factory :floor do
    sequence(:name)  { |n| "Floor ##{n}" }
    positition 1
    deleted false
    map nil
    location nil
  end

end
