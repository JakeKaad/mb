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

  describe "POST create" do
    let(:customer) { create :customer }
    let(:user) { create :user }
    let(:card_params) { attributes_for :contact_card}

    before do
      login user
      post :create, customer_id: customer.id, contact_card: card_params
    end

    it "should create a contact card" do
      expect(customer.contact_cards).to_not be_empty
    end

    it "should assign @customer" do
      expect(assigns(:customer)).to eq customer
    end

    it "should assign @contact_card with new params" do
      expect(assigns(:contact_card).email).to eq card_params["email"]
    end
  end

  describe "GET edit" do
    let(:user) { create :user }
    let(:customer) { create :customer }
    let(:card) {create :contact_card, contactable: customer }

    before do
      login user
      get :edit, customer_id: customer.id, id: card.id
    end

    it "should assign @customer" do
      expect(assigns(:customer)).to eq customer
    end

    it "should assign @contact_crd" do
      expect(assigns(:contact_card)).to eq card
    end
  end

  describe "POST update" do
    let(:user) { create :user }
    let(:customer) { create :customer }
    let(:card) {create :contact_card, contactable: customer }

    before do
      login user
      post :update, customer_id: customer.id, id: card.id, contact_card: { email: "New@email.com" }
    end

    it "should assign @customer" do
      expect(assigns(:customer)).to eq customer
    end

    it "should assign @contact_crd" do
      expect(assigns(:contact_card)).to eq card
    end

    it "should update @contact_card" do
      expect(card.reload.email).to eq "New@email.com"
    end
  end
end
