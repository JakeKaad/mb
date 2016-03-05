class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   ####################################
   ### Relations
   ####################################

   has_many :bookings
   has_many :booked_events, through: :bookings, class_name: "Event", foreign_key: :event_id
   has_and_belongs_to_many :events

   has_many :contact_cards, as: :contactable

   ####################################
   ### Validations
   ####################################

   validates_presence_of :email

   def phone
     main_contact.phone
   end

   private

   def main_contact
     contact_cards.where(main: true).first
   end


end
