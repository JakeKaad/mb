module FeatureMacros
  def login user
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"
    expect(page).to have_content "Signed in successfully."
  end
end
