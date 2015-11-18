FactoryGirl.define do
  factory :software_package do
    name "MyString"
    version "MyString"
    note "MyString"
    association(:image)
  end

end
