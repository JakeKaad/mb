class ContactCard < ActiveRecord::Base

  ####################################
  ### Relations
  ####################################

  belongs_to :contactable, polymorphic: true

  ####################################
  ### Validations
  ####################################

  validates_presence_of :contactable_id
  validates_presence_of :contactable_type
end
