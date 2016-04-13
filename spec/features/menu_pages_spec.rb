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

  scenario "adding and removing menu items", js: true do
    create :menu, event: event, base_rate: 27.0, final_price: 27.0

    visit company_event_path company, event
    click_link "Menu"

    select option.name, from: "Menu option"
    expect(find('#menu_item_course').value).to eq option.suggested_course
    expect(find('#menu_item_price_adjustment').value).to eq option.suggested_price_adjustment.to_s

    click_on "Create menu item"
    expect(page).to have_content "#{option.name} added to menu."
    expect(page).to have_content (27.0 + option.suggested_price_adjustment)

    click_link "Remove item"
    expect(page).to have_content "#{option.name} removed from menu"
    expect(page).to have_content 27.0

    select "Add a new one", from: "Menu option"
    fill_in "Name", with: "Kimchi Tacos"
    fill_in "Cuisine", with: "Fusion"
    fill_in "Suggested course", with: "Appetizer"
    fill_in "Suggested price adjustment", with: 2.0
    click_on "Create menu item"

    expect(page).to have_content "Kimchi Tacos added to menu."
    expect(page).to have_content 29.0
  end
end
