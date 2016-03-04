require 'rails_helper'

describe Event do
  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }
  it { should have_many :documents }
  it { should belong_to :room }
  it { should have_one :info }

  it { should have_one(:booking) }
  it { should have_many(:primary_contacts).through(:booking).source(:customer) }
  it { should have_and_belong_to_many(:customers) }

  it { should accept_nested_attributes_for :primary_contacts }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :name }
  it { should validate_presence_of :room_id }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :date }
  it { should validate_presence_of :company_id }
end
