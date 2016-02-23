require 'rails_helper'

describe CompaniesController do
  include ControllerMacros

  describe "GET show" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:user) { create :user }

      before { login user }

      it "should render the company" do
        get :show, id: company.id
        expect(assigns(:company)).to eq company
      end
    end
  end
end
