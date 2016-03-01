class Info < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :event
  has_many :notes, as: :notable

  ####################################
  ### Validations
  ####################################
end
