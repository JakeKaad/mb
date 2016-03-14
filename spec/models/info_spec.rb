require 'rails_helper'

describe Info do
  it { should belong_to :event }
  it { should have_many :notes }
end
