require 'rails_helper'

describe Document do

  ####################################
  ### Relations
  ####################################

  it { should belong_to :company }
  it { should belong_to :event }

  ####################################
  ### Validations
  ####################################

  it { should validate_presence_of :company_id }

  ####################################
  ### Paperclip
  ####################################

  it { should have_attached_file :file }
  it { should validate_attachment_presence(:file) }
  it { should validate_attachment_content_type(:file)
    .allowing('application/vnd.openxmlformats-officedocument.wordprocessingml.document') }
end
