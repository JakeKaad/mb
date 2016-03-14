class MenuOption < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :menu_items


  ####################################
  ### Validations
  ####################################

  validates_presence_of :name
end
