require 'rails_helper'

describe User do

  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
