require 'rails_helper'

feature "Company and meta information" do
  let(:user) { create :user }
  let(:company) { user.company }
  let!(:event_without_info) { create :event, company: company }
  let!(:event_with_info) { create :event_with_info, company: company }

  scenario "event without info should display the info form" do
    visit company_event_path company, event_without_info
    expect(page).to have_content "Add event information"
  end

  scenario "event with info should display event info" do
    visit company_event_path company, event_with_info
    info = event_with_info.info
    expect(page).to have_content info.linen_colors
  end
end
