class Document < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :company
  belongs_to :event

  ####################################
  ### Validations
  ####################################

  validates_presence_of :company_id
  validates_presence_of :file

  ####################################
  ### Paperclip
  ####################################
  has_attached_file :file
  validates_attachment_content_type :file, content_type: [ 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
end
