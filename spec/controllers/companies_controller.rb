require 'rails_helper'

describe CompaniesController do
  include ControllerMacros

  describe "GET show" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:event_one) { create :event, company: company }
      let(:event_two) { create :event, company: company }
      let(:user) { create :user }

      before do
        login user
        get :show, params: { id: company.id }
      end

      it "should assign @company" do
        expect(assigns(:company)).to eq company
      end

      it "should assign @events" do
        expect(assigns(:events)).to eq [event_one, event_two]
      end
    end
  end
end
