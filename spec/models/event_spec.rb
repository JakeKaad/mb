require 'rails_helper'

describe Event do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
  it { should validate_presence_of :event_hall }
  it { should validate_presence_of :start_time }
end
