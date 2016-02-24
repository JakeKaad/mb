# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first_or_create email: "test@test.com", password: "password", first_name: "Test", last_name: "User"
company = Company.first_or_create name: "MB"
n = 1
15.times do
  company.events.create start_time: n.weeks.from_now, name: "event #{n}", event_hall: ["LB", "GB"].sample
end
company.users << user
