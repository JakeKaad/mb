class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   ####################################
   ### Relations
   ####################################

   belongs_to :company

   ####################################
   ### Validations
   ####################################

   validates_presence_of :first_name, :last_name
end
