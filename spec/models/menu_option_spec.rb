require 'rails_helper'

describe MenuOption do
  ####################################
  ### Relations
  ####################################

  it { should have_many :menu_items }
  it { should have_many(:menus).through(:menu_items) }
  it { should belong_to :company }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
  it { should validate_presence_of :company_id }
  context "name uniqueness" do
    let(:subject) { build :menu_option, name: "blah"}

    it { should validate_uniqueness_of :name }
  end
end
