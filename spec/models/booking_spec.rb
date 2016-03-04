require 'rails_helper'

describe Booking do

  it { should belong_to :company }
  it { should belong_to(:customer) }
  it { should belong_to(:event) }
end
