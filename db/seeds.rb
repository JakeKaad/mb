
event_names = []

10.times { event_names << "#{Faker::Name.first_name} & #{Faker::Name.first_name}'s Wedding"}
10.times { event_names << "#{Faker::Company.name}'s Company Party" }
10.times { event_names << "#{Faker::Name.first_name}'s School Auction" }


user = User.first_or_create email: "test@test.com", password: "password", first_name: "Test", last_name: "User"
company = Company.first_or_create name: "Melody Ballroom"
n = 1
15.times do
  company.events.create date: n.weeks.from_now, start_time: n.weeks.from_now, name: event_names.sample, event_hall: ["Lower Ballroom", "Grand Ballroom"].sample
  n += 1
end

company.users << user
