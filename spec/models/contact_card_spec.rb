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
    let(:card) { build :contact_card, contactable: customer, main: true }
    let!(:card_two) { create :contact_card, contactable: customer, main: true, phone: "5555555555" }

    # before { customer.contact_cards << card_two }
    it "should prevent two cards from being the main contact card" do
      expect(card.valid?).to be_falsey
    end

    it "should allow secondary contact information" do
      card.main = false
      expect(card.valid?).to be_truthy
    end
  end
end
