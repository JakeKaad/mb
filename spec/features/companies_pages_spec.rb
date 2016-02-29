require 'rails_helper'


feature "Interacting with the company dashboard" do
  include FeatureMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let!(:event1) { create :event, company: company }
  let!(:event2) { create :event, company: company }
  let(:event_params) { attributes_for :event }

  before { login user }

  scenario "company dashboard displays correctly" do
    expect(page).to have_content "#{company.name} Dashboard"
    expect(page).to have_content event1.name
    expect(page).to have_content event1.event_date
    expect(page).to have_content event2.name
    expect(page).to have_content event2.event_date
  end

  scenario "adding a new event" do
    room = create :room, company: company
    click_on "Add event"

    fill_in "Name", with: event_params[:name]
    select room.name, from: "Room"
    fill_in "Start time", with: "02:30 PM"
    fill_in "event_date", with: "2016-12-12"

    click_on "Create event"
    expect(page).to have_content "Event added"
    expect(page).to have_content event_params[:name]
  end
end
