FactoryGirl.define do
  factory :area do
    sequence(:name) { |n| "Area #{n+50}"}
    department "LCS"
    special_access false
    map nil
    notes nil
    association :location
    floor { FactoryGirl.create(:floor, location: location) }

  end

end
