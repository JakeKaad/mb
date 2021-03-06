
event_names = []

10.times { event_names << "#{Faker::Name.first_name} & #{Faker::Name.first_name}'s Wedding"}
10.times { event_names << "#{Faker::Company.name}'s Company Party" }
10.times { event_names << "#{Faker::Name.first_name}'s School Auction" }




user = User.first_or_create email: "test@test.com", password: "password", first_name: "Test", last_name: "User"
company = Company.first_or_create name: "Melody Ballroom"

company.rooms.create name: "Grand Ballroom", max_occupancy: 880
company.rooms.create name: "Lower Ballroom", max_occupancy: 290
company.rooms.create name: "Both Rooms", max_occupancy: 1450
n = 1
15.times do
  event = Event.create date: n.weeks.from_now, start_time: n.weeks.from_now, name: event_names.sample, room_id: company.rooms.sample.id
  company.events << event
  event.primary_contact = Customer.create email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "password"
  event.primary_contact.contact_cards.create(
    phone: Faker::PhoneNumber.phone_number,
    street_address: Faker::Address.street_address,
    address_second_line: Faker::Address.secondary_address,
    email: Faker::Internet.email,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip
  )
  event.customers << event.primary_contact
  Booking.create event_id: event.id, customer_id: event.primary_contact.id, company_id: company.id
  n += 1
end

foods = %w(meatballs pizza chicken-strips crudite fruit-tray caesar-salad spinach-salad bread prime-rib potatoes)
courses = %w(appetizer salad carving entree starch)
foods.each do |food|
  MenuOption.create(
      name: food,
      description: Faker::Lorem.sentence,
      cuisine: Faker::Lorem.word,
      suggested_course: courses.sample,
      suggested_price_adjustment: (0..4).to_a.sample
    )
end
company.users << user
