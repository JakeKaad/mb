require 'rails_helper'

feature "notes on event information" do
  include FeatureMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let!(:event) { create :event_with_info, company: company }

  before do
     login_as(user, scope: :user)
     event.add_primary create :customer
     event.primary_contact.contact_cards.create(attributes_for :contact_card)
     visit root_path
   end

  scenario "we can add new notes" do
    visit company_event_path company, event
    fill_in "Message", with: "Something noteworthy"
    click_on "Add note"
    expect(page).to have_content "Note saved."
    expect(page).to have_content "Something noteworthy"
  end

  scenario "we can edit notes", js: true do
    visit company_event_path company, event
    fill_in "Message", with: "Something noteworthy"
    click_on "Add note"
    sleep 0.1
    click_on "edit_#{Note.first.id}_button"
    find(".input-#{Note.first.id}-message").set "Something noteworthier"
    click_on "Update note"
    expect(page).to have_content "Something noteworthier"
  end
end
