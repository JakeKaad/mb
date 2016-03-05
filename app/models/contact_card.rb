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

  validate :only_one_main_per_contactable
  scope :main, -> {  where(main: true) }

  def main?
    main
  end

  protected

  def only_one_main_per_contactable
    return unless main?

    matches = contactable.contact_cards.main

    if persisted?
      matches = matches.where('id != ?', id)
    end
    if matches.exists?
      errors.add(:contact_card, 'cannot have more than one main contact card')
    end
  end
end
