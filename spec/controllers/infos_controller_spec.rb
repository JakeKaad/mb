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
        post :create, params: { event_id: event.id, info: info_params }
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

      it "assigns info properties" do
        info = event.info
        info.napkin_colors = info_params["napkin_colors"]
      end
    end
  end

  describe 'GET edit' do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info) { create :info, event: event}

    context "success" do
      before do
        login user
        get :edit, params: { event_id: event.id, id: info.id }
      end

      it "should set @event" do
        expect(assigns(:event)).to eq event
      end

      it "should set @info" do
        expect(assigns(:info)).to eq info
      end

      it "should redirect html requests to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH update' do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info) { create :info, event: event}

    context "success" do
      before do
        login user
        post :update, params: {
          event_id: event.id, id: info.id, info: { napkin_colors: "PINK AND YELLOW"}
        }
      end

      it "should set @event" do
        expect(assigns(:event)).to eq event
      end

      it "should set @info" do
        expect(assigns(:info)).to eq info
      end

      it "should redirect html requests to root path" do
        expect(response).to redirect_to root_path
      end

      it "should update info" do
        expect(info.reload.napkin_colors).to eq "PINK AND YELLOW"
      end
    end
  end
end
