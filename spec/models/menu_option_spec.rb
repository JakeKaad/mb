require 'rails_helper'

describe MenuOption do
  ####################################
  ### Relations
  ####################################

  it { should have_many :menu_items }
  it { should have_many(:menus).through(:menu_items) }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
end
