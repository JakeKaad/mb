require 'rails_helper'

describe ContactCard do
  ####################################
  ### Relations
  ####################################

  it { should belong_to(:contactable) }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of(:contactable_id) }
  it { should validate_presence_of(:contactable_type) }
end
