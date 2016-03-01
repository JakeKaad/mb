require 'rails_helper'

describe InfosController do
  include ControllerMacros


  describe "Post create" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info_params) { attributes_for :info}

    context "success" do
      before do
        login user
        post :create, event_id: event.id, info: info_params
      end

      it "redirects to the events show page" do
        expect(response).to redirect_to company_event_path company, event
      end

      it "creates the info object" do
        expect(Info.all).to_not be_empty
      end

      it "assigns @event " do
        expect(assigns(:event)).to eq event
      end

      it "assigns doesn't handle event " do
        expect(assigns(:event_details)).to be_nil
      end

      it "fills the flash notice" do
        expect(flash[:notice]).to_not be_empty
      end
    end
  end
end
