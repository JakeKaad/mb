class Event < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :company

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name, :event_hall, :start_time, :company_id
end
