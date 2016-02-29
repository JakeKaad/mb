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

      context "with no info created" do
        it "should assign @info as a new record if it doesn't exist" do
          expect(assigns(:info).new_record?).to be_truthy
        end
      end

      context "with info created" do
        let!(:info) { create :info, event: event}
        it "should assign @info as the event's info record if it does exist" do
          get :show, company_id: company.id, id: event.id
          expect(assigns(:info)).to eq info.reload
        end
      end
    end
  end

  describe "GET new" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:user) { create :user }

      before do
        login user
        get :new, company_id: company.id
      end

      it "should assign @company" do
        expect(assigns(:company)).to eq company
      end

      it "should assign @events" do
        expect(assigns(:event).new_record?).to be_truthy
      end
    end
  end

  describe "POST create" do
    context "as a logged in user" do
      let(:company) { user.company }
      let(:event_params) { attributes_for :event }
      let(:user) { create :user }

      before do
        login user
      end

      context "with valid inputs" do
        before { post :create, company_id: company.id, event: event_params }
        it "should assign @company" do
          expect(assigns(:company)).to eq company
        end

        it "should create an event " do
          expect(Event.count).to eq 1
          expect(company.events.count).to eq 1
        end

        it "should redirect to the event show page" do
          expect(response).to redirect_to company_event_path(company, Event.first)
        end

        it "should render a flash notice" do
          expect(flash[:notice]).to_not be_empty
        end
      end

      context "with invalid inputs" do
        before do
          event_params[:name] = nil
          post :create, company_id: company.id, event: event_params
        end

        it "should assign @company" do
          expect(assigns(:company)).to eq company
        end

        it "shouldn't create an event " do
          expect(Event.count).to eq 0
          expect(company.events.count).to eq 0
        end

        it "should render the form" do
          expect(response).to render_template :new
        end

        it "should render a flash alert" do
          expect(flash[:alert]).to_not be_empty
        end
      end
    end
  end
end
