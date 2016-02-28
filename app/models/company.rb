class Company < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  has_many :users
  has_many :events
  has_many :documents
  has_many :rooms

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
