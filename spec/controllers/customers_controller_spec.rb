require 'rails_helper'

describe CustomersController do
  include ControllerMacros

  describe "GET New" do
    let(:customer) { create :customer }
    let(:user) { create :user }
    let(:event) { create :event, company: user.company }
    let(:primary) { create :customer }
    let!(:contact_card) { create :contact_card, contactable: primary }
    let!(:booking) { create :booking, event_id: event.id, customer_id: primary.id, company_id: user.company.id }

    before do
      login user
      get :new, params: { event_id: event.id }
    end

    it "should set @event" do
      expect(assigns(:event)).to eq event
    end

    it "should set @customer" do
      expect(assigns(:customer).new_record?).to be_truthy
      expect(assigns(:customer).class).to eq Customer
    end

    it "should set @contact_card" do
      expect(assigns(:contact_card).new_record?).to be_truthy
      expect(assigns(:contact_card).class).to eq ContactCard
    end
  end

  describe "POST create" do
    let(:customer) { create :customer }
    let(:user) { create :user }
    let(:event) { create :event, company: user.company }
    let(:primary) { create :customer }
    let!(:contact_card) { create :contact_card, contactable: primary }
    let(:customer_params) { attributes_for :customer }
    let(:card_params) { attributes_for :contact_card }
    let!(:booking) { create :booking, event_id: event.id, customer_id: primary.id, company_id: user.company.id }

    before do
      login user
      event.customers << primary
      post :create, params: { event_id: event.id, customer: customer_with_nested_params(customer_params, card_params) }
    end

    it "should set @event" do
      expect(assigns(:event)).to eq event
    end

    it "should create a new customer" do
      expect(event.customers.size).to eq 2
    end

    it "should create a new contact_card" do
      expect(event.customers.last.contact_cards).to_not be_empty
    end

    it "should set @customers" do
      expect(assigns(:customers)).to eq event.customers
    end
  end
end

def customer_with_nested_params customer_attributes, card_attributes
  customer_attributes[:contact_card] = card_attributes
  customer_attributes
end
