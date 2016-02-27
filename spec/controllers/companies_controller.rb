require 'rails_helper'

describe CompaniesController do
  include ControllerMacros

  describe "GET show" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:event_one) { create :event, company: company }
      let(:event_two) { create :event, company: company }
      let(:user) { create :user }

      before { login user }

      it "should assign @company" do
        get :show, id: company.id
        expect(assigns(:company)).to eq company
      end

      it "should assign @events" do
        get :show, id: company.id
        expect(assigns(:events)).to eq [event_one, event_two]
      end
    end
  end
end
