class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   ####################################
   ### Relations
   ####################################

   has_many :bookings
   has_many :booked_events, through: :bookings, foreign_key: "event_id", class_name: "Event"
   has_many :companies, through: :bookings
   has_and_belongs_to_many :events

   ####################################
   ### Validations
   ####################################

   validates_presence_of :email
end
