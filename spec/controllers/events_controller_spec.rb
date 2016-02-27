require 'rails_helper'

describe EventsController do
  include ControllerMacros

  describe "GET show" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:event) { create :event, company: company }
      let(:user) { create :user }

      before do
        login user
        get :show, company_id: company.id, id: event.id
      end

      it "should assign @company" do
        expect(assigns(:company)).to eq company
      end

      it "should assign @events" do
        expect(assigns(:event)).to eq event
      end
    end
  end
end
