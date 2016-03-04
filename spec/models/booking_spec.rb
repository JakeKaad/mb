require 'rails_helper'

describe Booking do

  it { should belong_to :company }
  it { should belong_to(:customer) }
  it { should belong_to(:event) }

  it { should validate_presence_of :event_id }
  it { should validate_presence_of :company_id }
  it { should validate_presence_of :customer_id }
end
