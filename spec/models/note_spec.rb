require 'rails_helper'

describe Note do
  it { should belong_to(:notable) }
  it { should belong_to(:event) }
end
