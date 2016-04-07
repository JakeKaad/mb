require 'rails_helper'

describe MenusController do
  include ControllerMacros

  describe "POST create" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:menu_params) { attributes_for :menu}

    context "success" do
      before do
        login user
        post :create, params: { event_id: event.id, menu: menu_params }
      end

      it "redirects to the events show page" do
        expect(response).to redirect_to company_event_path(company, event, event_tab: "menu")
      end

      it "creates a menu object" do
        expect(Menu.count).to eq 1
      end

      it "sets @menu" do
        expect(assigns(:menu)).to eq event.menu
      end

      it "sets @event" do
        expect(assigns(:event)).to eq event
      end

      it "sets a success message" do
        expect(flash[:notice]).to_not be_empty
      end
    end

    context "failure" do
      before do
        login user
        menu_params[:base_rate] = nil
        post :create, params: { event_id: event.id, menu: menu_params }
      end

      it "redirects to the events show page with" do
        expect(response).to redirect_to company_event_path(company, event, event_tab: "menu")
      end

      it "doesn't create a menu object" do
        expect(Menu.count).to eq 0
      end

      it "sets @menu" do
        expect(assigns(:menu).new_record?).to be_truthy
      end

      it "sets @event" do
        expect(assigns(:event)).to eq event
      end

      it "sets a failure message" do
        expect(flash[:alert]).to_not be_empty
      end
    end
  end
end
