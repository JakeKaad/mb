FactoryGirl.define do
  factory :event do
    start_time 3.weeks.from_now
    date 3.weeks.from_now
    room_id 1
    name "#{Faker::Name.first_name} & #{Faker::Name.first_name}'s Wedding"
    company
  end
end
