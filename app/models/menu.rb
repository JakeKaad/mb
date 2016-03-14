class Menu < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :event

  ####################################
  ### Validations
  ####################################

  validates_presence_of :service_style
  validates_presence_of :rate_type
  validates_presence_of :base_rate
  validates_presence_of :final_price
  validates_presence_of :event_id
  
end
