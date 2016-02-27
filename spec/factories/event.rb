FactoryGirl.define do
  factory :event do
    start_time 3.weeks.from_now
    event_hall "Grand Ballroom"
    name "Tony & Tina's Wedding"
    company
  end
end
