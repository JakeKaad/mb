class Company < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :users


  ####################################
  ### Validations
  ####################################

  validates_presence_of :name
end
