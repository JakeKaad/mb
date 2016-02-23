# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "password"
    first_name "Moe"
    last_name "schmoe"
    company
  end
end
