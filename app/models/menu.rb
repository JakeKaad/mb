class Menu < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :event
  has_many :menu_items
  has_many :menu_options, through: :menu_items

  ####################################
  ### Validations
  ####################################

  validates_presence_of :service_style
  validates_presence_of :rate_type
  validates_presence_of :base_rate
  validates_presence_of :final_price
  validates_presence_of :event_id

  before_validation :set_final_price

  private

  def set_final_price
    self.final_price = self.base_rate if self.final_price.nil?
  end
end
