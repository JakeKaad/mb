require 'rails_helper'

describe Customer do
  ####################################
  ### Relations
  ####################################
  it { should have_many :bookings }
  it { should have_many(:companies).through(:bookings) }
  it { should have_many(:booked_events).through(:bookings).class_name("Event").with_foreign_key(:event_id) }
  it { should have_and_belong_to_many(:events) }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :email }
end
