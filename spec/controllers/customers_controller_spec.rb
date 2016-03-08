require 'rails_helper'

describe CustomersController do
  include ControllerMacros

  describe "get New" do
    let(:customer) { create :customer }
    let(:user) { create :user }
    let(:event) { create :event }
    let(:primary) { create :customer }
    let!(:contact_card) { create :contact_card, contactable: primary }
    let!(:booking) { create :booking, event_id: event.id, customer_id: primary.id, company_id: user.company.id }

    before do
      login user
      get :new, event_id: event.id
    end

    it "should set @event" do
      expect(assigns(:event)).to eq event
    end

    it "should set @customer" do
      expect(assigns(:event)).to eq event
    end
  end
end
