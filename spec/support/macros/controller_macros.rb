module ControllerMacros
  def login user=nil
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryGirl.create(:user)
    sign_in user
  end
end
