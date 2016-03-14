class MenuItem < ActiveRecord::Base
  ####################################
  ### Relations
  ####################################

  belongs_to :menu
  belongs_to :menu_option

  ####################################
  ### Validations
  ####################################

  validates_presence_of :menu_id
  validates_presence_of :menu_option_id
end
