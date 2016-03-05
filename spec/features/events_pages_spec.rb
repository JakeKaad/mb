require 'rails_helper'

feature "Company and meta information" do
  include FeatureMacros
  include InfoMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let!(:event_without_info) { create :event, company: company }
  let!(:event_with_info) { create :event_with_info, company: company }

  before do
    login user
    event_without_info.add_primary create :customer
    event_with_info.add_primary create :customer
  end

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

  scenario "a user can add notes to info page" do
    visit company_event_path company, event_with_info
    fill_in "Message", with: "Something noteworthy."
    click_on "Add note"
    expect(page).to have_content "Note saved."
  end

  scenario "a user can't add notes without messages" do
    visit company_event_path company, event_with_info
    click_on "Add note"
    expect(page).to have_content "Something went wrong, note not saved."
  end

  scenario "can update setup information", js: true do
    visit company_event_path company, event_with_info
    click_on "edit_#{event_with_info.info.id}"
    fill_in "Linen colors", with: "PINK AND YELLOW"
    click_on "Update info"
    expect(page).to have_content "PINK AND YELLOW"
    expect(event_with_info.info.reload.linen_colors).to eq "PINK AND YELLOW"
  end
end
