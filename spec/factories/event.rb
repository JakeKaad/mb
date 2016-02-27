FactoryGirl.define do
  factory :event do
    start_time 3.weeks.from_now
    date 3.weeks.from_now
    event_hall "Grand Ballroom"
    name "#{Faker::Name.first_name} & #{Faker::Name.first_name}'s Wedding"
    company
  end
end
