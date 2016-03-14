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
end
