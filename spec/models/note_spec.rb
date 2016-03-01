require 'rails_helper'

describe Note do
  it { should belong_to(:notable) }
  it { should belong_to(:event) }
  it { should validate_presence_of(:event_id) }
  it { should validate_presence_of(:message) }
end
