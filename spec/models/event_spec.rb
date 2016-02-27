require 'rails_helper'

describe Event do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }
  it { should have_many :documents }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
  it { should validate_presence_of :event_hall }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :date }
  it { should validate_presence_of :company_id }
end
