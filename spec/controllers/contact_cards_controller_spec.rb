require 'rails_helper'

describe ContactCardsController do
  include ControllerMacros

  describe "get New" do
    let(:customer) { create :customer }
    let(:user) { create :user }

    before { login user }

    it "should assign @customer" do
      get :new, customer_id: customer.id
      expect(assigns(:customer)).to eq customer
    end


    it "should assign @contact_card" do
      get :new, customer_id: customer.id
      expect(assigns(:contact_card).new_record?).to be_truthy
      expect(assigns(:contact_card).class).to eq ContactCard
    end
  end
end
