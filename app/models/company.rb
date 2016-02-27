class Company < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :users
  has_many :events
  has_many :documents

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name
end
