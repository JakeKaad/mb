require 'rails_helper'

describe Customer do
  ####################################
  ### Relations
  ####################################
  it { should have_many :bookings }
  it { should have_many(:booked_events).through(:bookings).class_name("Event").with_foreign_key(:event_id) }
  it { should have_and_belong_to_many(:events) }

  it { should have_many :contact_cards }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :email }

  describe "#phone" do
    let(:customer) { create :customer }
    let!(:card) { create :contact_card, contactable: customer }
    let!(:card_two) { create :contact_card, contactable: customer, main: true, phone: "5555555555" }
    let!(:card_three) { create :contact_card, contactable: customer }

    before do
      # customer.contact_cards << card
      # customer.contact_cards << card_two
    end

    it "it should return the phone number from the primary card" do
      binding.pry
      expect(customer.phone).to eq card_two.phone
    end
  end
end
