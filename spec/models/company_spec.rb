require 'rails_helper'

describe Company do


  ####################################
  ### Relations
  ####################################

  it { should have_many :users }
  it { should have_many :events }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
end
