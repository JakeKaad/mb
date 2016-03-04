class Booking < ActiveRecord::Base

  belongs_to :event
  belongs_to :company
  belongs_to :customer
  validates_presence_of :event_id, :customer_id, :company_id
end
