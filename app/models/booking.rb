class Booking < ActiveRecord::Base
  belongs_to :company
  belongs_to :booked_event, class_name: "Event", foreign_key: :event_id
  belongs_to :primary_contact, class_name: "Customer", foreign_key: :customer_id


  validates_presence_of :event_id, :customer_id, :company_id
  validates_uniqueness_of :event_id, scope: :customer_id
end
