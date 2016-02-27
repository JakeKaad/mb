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
  validates_attachment_content_type :file,
    content_type: [ 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'],
    s3_credentials: Proc.new{|a| a.instance.s3_credentials }

  def def s3_credentials
    {bucket: ENV['S3_BUCKET'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}
  end

  def file_name
    file_file_name
  end

end
