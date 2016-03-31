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
        get :show, params: { company_id: company.id, id: event.id }
      end

      it "should assign @company" do
        expect(assigns(:company)).to eq company
      end

      it "should assign @events" do
        expect(assigns(:event)).to eq event
      end

      it "should assign @event_details" do
        expect(assigns(:event_details)).to_not be_nil
      end

      context "with no info created" do
        it "should assign @info as a new record if it doesn't exist" do
          expect(assigns(:event_details).info.new_record?).to be_truthy
        end
      end

      context "with info created" do
        let!(:info) { create :info, event: event}
        it "should assign @info as the event's info record if it does exist" do
          get :show, params: { company_id: company.id, id: event.id }
          expect(assigns(:event_details).info).to eq info.reload
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
        get :new, params: { company_id: company.id }
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
      let(:event_params) { attributes_for :event_params }
      let(:user) { create :user }
      let(:customer_params) { attributes_for :customer }
      let(:contact_params) { attributes_for :contact_card }

      before do
        login user
      end

      context "with valid inputs" do
        before do
           post :create, params: {
             company_id: company.id,
             event: event_with_nested_attributes(event_params, customer_params, contact_params)
           }
          end

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

        it "should assign @primary_contact" do
          expect(assigns(:event).primary_contact.email).to eq customer_params[:email]
        end

        it "should create a Booking" do
          expect(Booking.first.event_id).to eq assigns(:event).id
        end

        it "should set up relationships properly" do
          expect(Event.first.primary_contact).to eq Customer.first
          expect(Customer.first.booked_events).to include Event.first
        end

        it "should create a contact card for customer" do
          expect(assigns(:event).primary_contact.contact_cards).to_not be_empty
        end
      end

      context "with invalid inputs" do
        before do
          event_params[:name] = nil
          post :create, params: {
            company_id: company.id, event: event_with_nested_attributes(event_params, customer_params, contact_params)
          }
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


def event_with_nested_attributes event_params, customer_attributes, contact_attributes
  event_params[:primary_contact_attributes] = customer_attributes
  event_params[:contact_card] = contact_attributes
  event_params
end
