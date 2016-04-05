class MenuOption < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :menu_items
  has_many :menus, through: :menu_items


  ####################################
  ### Validations
  ####################################

  validates_presence_of :name

  validates_uniqueness_of :name


end
