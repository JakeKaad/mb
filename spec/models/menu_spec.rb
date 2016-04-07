require 'rails_helper'

describe Menu do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :event }
  it { should have_many :menu_items }
  it { should have_many(:menu_options).through :menu_items }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :service_style }
  it { should validate_presence_of :rate_type }
  it { should validate_presence_of :base_rate }
  it { should validate_presence_of :final_price }
  it { should validate_presence_of :event_id }

  describe "#set_final_price" do
    let(:menu) { build :menu, final_price: nil}

    it "should set the price on save" do
      menu.save
      expect(menu.final_price).to eq menu.base_rate
    end

    it "should have set_final_price called" do
      menu.save
    end
  end

  describe "#increase price" do
    let(:menu) { create :menu, final_price: 30}
    
    before { menu.increase_price 3 }

    it "should increase the price" do
      expect(menu.final_price).to eq 33
    end
  end
end
