require 'rails_helper'

describe ContactCard do
  ####################################
  ### Relations
  ####################################

  it { should belong_to(:contactable) }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of(:contactable_id) }
  it { should validate_presence_of(:contactable_type) }


  describe "#only_one_main_per_contactable" do
    let(:customer) { create :customer }
    let(:card) { build :contact_card, contactable: customer }
    let!(:card_two) { create :contact_card, contactable: customer, phone: "5555555555" }

    # before { customer.contact_cards << card_two }
    it "should prevent two cards from being the main contact card" do
      card.main = true
      expect(card.valid?).to be_falsey
    end

    it "should allow secondary contact information" do
      card.main = false
      expect(card.valid?).to be_truthy
    end

    it "should allow main contact to be updated" do
      card_two.update(email: "new_email@test.com")
      expect(card.valid?).to be_truthy
    end
  end

  describe "#assign_main" do
    let(:customer) { create :customer }
    let!(:card) { create :contact_card, contactable: customer }
    let(:card_two) { create :contact_card, contactable: customer }

    it "should assign main if it is the first contact card" do
      expect(card.main).to be_truthy
    end

    it "shouldnt assign main to second contact card" do
      expect(card_two.main).to be_falsey
    end
  end
end
