require 'rails_helper'

describe Company do
  ####################################
  ### Relations
  ####################################

  it { should have_many :users }
  it { should have_many :events }
  it { should have_many :documents }
  it { should have_many :rooms }
  it { should have_many :bookings }
  it { should have_many(:primary_contacts).through(:bookings).class_name("Customer").with_foreign_key("primary_contact_id") }
  it { should have_many(:booked_events).through(:bookings).class_name("Event").with_foreign_key("booked_event_id") }
  
  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }


  describe "#rooms_for_select" do
    let(:company) { create :company }
    let!(:room1) { create :room, company: company }
    let!(:room2) { create :room, company: company }

    it "should return a 2d of room names and Ids" do

      expect(company.rooms_for_select).to eq [[room1.name, room1.id], [room2.name, room2.id]]
    end
  end
end
