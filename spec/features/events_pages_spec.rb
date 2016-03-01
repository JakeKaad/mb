require 'rails_helper'

feature "Company and meta information" do
  include FeatureMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let!(:event_without_info) { create :event, company: company }
  let!(:event_with_info) { create :event_with_info, company: company }

  before { login user }

  scenario "event without info should display the info form" do
    visit company_event_path company, event_without_info
    expect(page).to have_content "Add event information"
  end

  scenario "event with info should display event info" do
    visit company_event_path company, event_with_info
    info = event_with_info.info
    expect(page).to have_content info.linen_colors
  end

  scenario "we can add new info" do
    visit company_event_path company, event_without_info
    fill_in_info_params
    click_on "Create info"
    expect(page).to have_content "Information added to #{event_without_info.name}"
  end

  scenario "it saves info properties" do
    visit company_event_path company, event_without_info
    info = build :info
    fill_in_info_params info
    click_on "Create info"

    expect(event_without_info.info.linen_colors).to eq info.linen_colors
  end
end

def fill_in_info_params info=nil
  info ||= build :info
  fill_in "Linen colors", with: info.linen_colors
  fill_in "Napkin colors", with: info.napkin_colors
  fill_in "Napkin fold", with: info.napkin_fold
  fill_in "Placesetting", with: info.placesetting
  fill_in "Centerpieces", with: info.centerpieces
  fill_in "Water service", with: info.water_service
  fill_in "Coffee service", with: info.coffee_service
  fill_in "Final guest count", with: info.final_guest_count
  fill_in "Number of tables", with: info.number_of_tables
  fill_in "Guests per table", with: info.guests_per_table
end
