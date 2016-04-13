class MenuOption < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :menu_items
  has_many :menus, through: :menu_items
  belongs_to :company

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :company_id

end
