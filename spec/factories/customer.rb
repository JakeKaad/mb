FactoryGirl.define do
  factory :customer do
    first_name "TEST"
    last_name "CUSTOMER"
    sequence(:email) { |n| "customer_{#{n}}@test.com" }
    password "password"
  end

  factory :primary_contact, class: Customer do
    first_name "TEST"
    last_name "CUSTOMER"
    sequence(:email) { |n| "pc{#{n}}@test.com" }
    password "password"
  end
end
