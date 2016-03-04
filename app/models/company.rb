class Company < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :users
  has_many :events
  has_many :documents
  has_many :rooms

  has_many :bookings
  has_many :booked_events, through: :bookings, class_name: "Event", foreign_key: "event_id"
  has_many :primary_contacts, through: :bookings, class_name: "Customer", foreign_key: "customer_id"

  ####################################
  ### Validations
  ####################################

  validates_presence_of :name


  def rooms_for_select
    rooms.map do |room|
      [room.name, room.id]
    end
  end
end
