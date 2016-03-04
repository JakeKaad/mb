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
  has_many :primary_contacts, through: :booking, source: :customer
  accepts_nested_attributes_for :primary_contacts
  ####################################
  ### Event-information Relations
  ####################################

  has_one :info

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

  def primary_contact
    primary_contacts.first
  end
end
