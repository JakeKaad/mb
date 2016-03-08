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


end
