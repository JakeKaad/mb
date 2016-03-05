require 'rails_helper'

describe Event do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }
  it { should have_many :documents }
  it { should belong_to :room }
  it { should have_one :info }

  it { should have_one(:booking) }
  it { should have_one(:primary_contact).through(:booking).class_name("Customer").with_foreign_key(:customer_id) }
  it { should have_and_belong_to_many(:customers) }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
  it { should validate_presence_of :room_id }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :date }
  it { should validate_presence_of :company_id }


  describe "#add_primary?" do
    let(:event) { create :event }
    let(:customer) { create :customer }

    it "should make customer the primary contact" do
      event.add_primary? customer
      expect(event.primary_contact).to eq customer
    end

    it "should add customer to event customers" do
      event.add_primary? customer
      expect(event.customers).to include customer
    end
  end
end
