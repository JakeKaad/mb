require 'rails_helper'

describe Menu do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :event }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :service_style }
  it { should validate_presence_of :rate_type }
  it { should validate_presence_of :base_rate }
  it { should validate_presence_of :final_price }
  it { should validate_presence_of :event_id }
end
