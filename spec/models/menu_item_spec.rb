require 'rails_helper'

describe MenuItem do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :menu }
  it { should belong_to :menu_option }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :menu_id }
  it { should validate_presence_of :menu_option_id }
  
  context "scope validation" do
    let(:menu) { build_stubbed :menu }
    let!(:other_menu_item) { create :menu_item, menu: menu}
    let(:subject) { build_stubbed :menu_item, menu: menu }

    it "shouldn't let you save second menu item" do
      expect(subject.valid?).to be_falsy
    end
  end
end
