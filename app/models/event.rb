class Event < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :company
  has_many :documents
  belongs_to :room

  ####################################
  ### Event-customer Relations
  ####################################
  has_and_belongs_to_many :customers

  has_one :booking
  has_one :primary_contact, through: :booking, class_name: "Customer", foreign_key: :customer_id
  accepts_nested_attributes_for :primary_contact
  ####################################
  ### Event-meta Relations
  ####################################

  has_one :info
  has_one :menu

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name, :room_id, :start_time, :company_id, :date

  ####################################
  ### Enum
  ####################################

  def event_date
    date.strftime("%A, %B %d %Y")
  end

  def hall
    event_hall
  end

  def add_primary? customer
    customers << customer
    Booking.create(event_id: id, customer_id: customer.id, company_id: company_id)
  end

  alias_method :add_primary, :add_primary?
end
