require 'rails_helper'

describe Room do

  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }
  it { should have_many :events }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :company_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :max_occupancy }
end
