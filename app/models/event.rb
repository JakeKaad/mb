class Event < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :company
  has_many :documents

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name, :event_hall, :start_time, :company_id

  def event_date
    start_time.strftime("%A, %B %d %Y")
  end

  def hall
    event_hall
  end
end
