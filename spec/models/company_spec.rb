require 'rails_helper'

describe Company do


  ####################################
  ### Relations
  ####################################

  it { should have_many :users }
  it { should have_many :events }
  it { should have_many :documents }
  it { should have_many :rooms }

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
