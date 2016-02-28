class Room < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :company
  has_many :events

  ####################################
  ### Validations
  ####################################

  validates_presence_of :company_id, :name, :max_occupancy
end
