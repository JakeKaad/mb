require 'rails_helper'

feature "Company and meta information" do
  include FeatureMacros
  include InfoMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let(:event) { create :event, company: company }
  let(:primary_contact) { create :customer }
  let!(:contact_card) { create :contact_card, contactable: primary_contact }

  before do
    login user
    Booking.create(event_id: event.id, customer_id: primary_contact.id, company_id: company.id)
    event.customers << primary_contact
  end

  it "should display a contact and their card", js: true do
    visit company_event_path(company, event)
    click_on "Contacts"
    expect(page).to have_content primary_contact.first_name
    expect(page).to have_content primary_contact.last_name
    expect(page).to have_content primary_contact.phone
    expect(page).to have_content primary_contact.main_card.street_address
  end

  it "should let us edit a card", js: true do
    visit company_event_path(company, event)
    click_on "Contacts"
    click_on "Edit"
    fill_in "Email", with: "new_email@test.com"
    click_on "Add contact information"
    expect(page).to have_content "new_email@test.com"
  end

  it "should let us add a card", js: true do
    visit company_event_path(company, event)
    click_on "Contacts"
    click_link "Add new contact card"
    fill_in "Email", with: "new_email@test.com"
    click_on "Add contact information"
    expect(page).to have_content "new_email@test.com"
  end

  it "should let us add a note", js: true do
    visit company_event_path(company, event)
    click_on "Contacts"
    click_link "Add note"
    fill_in "Message", with: "Something noteworthy"
    click_on "Create note"
    expect(page).to have_content "Something noteworthy"
  end

  it "should let us edit a note", js: true do
    note = Note.create(event_id: event.id, notable: primary_contact, message: "Noteworthy")
    visit company_event_path(company, event)
    click_on "Contacts"
    within "#note_#{note.id}_li" do
      click_link "Edit"
      fill_in "Message", with: "Something noteworthy"
      click_on "Update note"
    end
    expect(page).to have_content "Something noteworthy"
  end

  it "should let us add another customer", js: true do
    visit company_event_path(company, event)
    click_on "Contacts"
    click_on "Add another customer to event"
    fill_in "First name", with: "Johnny"
    fill_in "Last name", with: "Appleseed"
    fill_in "Email", with: "Johnny@trees.com"
    fill_in "Phone", with: "5555555550"
    fill_in "Street address", with: "123 E Main St."
    fill_in "Address second line", with: "Ste 200"
    fill_in "City", with: "portland"
    select "Oregon", from: "State"
    fill_in "Zip", with: "97214"
    click_on "Create customer"
    expect(page).to have_content "Johnny Appleseed"
  end
end
