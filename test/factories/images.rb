FactoryGirl.define do
  factory :image do
    sequence(:name) { |n| "some_cool_name_#{n}" }
    os_version "XP"
    os_name "Windows"
    deleted false
  end
end
