require 'rails_helper'

feature 'user interacting with menus' do
  include FeatureMacros

  let(:user) { create :user }
  let(:company) { user.company }
  let(:event) { create :event, company: company }
  let!(:option) { create :menu_option }

  before do
    login user
    setup_primary_contact event
  end

  scenario "creates a menu" do
    visit company_event_path company, event
    click_link "Menu"

    fill_in "Service style", with: "Buffet"
    fill_in "Rate type", with: "Per person"
    fill_in "Base rate", with: 27.0
    click_on "Create menu"

    expect(page).to have_content "Menu info added to #{event.name}."
  end

  scenario "adding menu items", js: true do
    create :menu, event: event

    visit company_event_path company, event
    click_link "Menu"

    select option.name, from: "Menu option"
    expect(find('#menu_item_course').value).to eq option.suggested_course
    expect(find('#menu_item_price_adjustment').value).to eq option.suggested_price_adjustment

    click_on "Create menu item"
  end
end
