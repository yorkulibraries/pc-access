FactoryGirl.define do
  factory :area do
    sequence(:name) { |n| "Area #{n+50}"}
    department "LCS"
    special_access false
    map nil
    notes nil
    association :location
    association :floor # random for now, but after create it will be associated with the location

    after(:create) do |area|
      area.floor.location.id = area.location.id
      #association :floor, location_id: area.location.id 
    end
  end

end
