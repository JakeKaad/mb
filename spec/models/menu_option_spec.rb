require 'rails_helper'

describe MenuOption do
  ####################################
  ### Relations
  ####################################

  it { should have_many :menu_items }
  
  ####################################
  ### Validations
  ####################################
end
