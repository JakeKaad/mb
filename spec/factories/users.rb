FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_{#{n}}@test.com" }
    password "password"
    first_name "Moe"
    last_name "schmoe"
    company
  end
end
