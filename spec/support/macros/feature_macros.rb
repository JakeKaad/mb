module FeatureMacros
  def login user
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"
    expect(page).to have_content "Signed in successfully."
  end

  def setup_primary_contact event 
    event.add_primary create :customer
    event.primary_contact.contact_cards.create(attributes_for :contact_card)
  end
end
