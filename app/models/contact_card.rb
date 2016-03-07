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
  scope :main_card, -> {  where(main: true).first }

  #####
  # Assign main to first contact card
  ####
  before_create :assign_main


  def main?
    main
  end

  protected

  def only_one_main_per_contactable
    return if main?

    if contactable_id.nil? || contactable_type.nil?
      errors.add(:contact_card, 'nobody is assigned to this card')
      return
    end

    match = contactable.contact_cards.main_card

    if persisted?
      match = contactable.contact_cards.where('id != ?', id)
    end

    if match.present?
      errors.add(:contact_card, 'cannot have more than one main contact card')
    end
  end

  def assign_main
    return if contactable.contact_cards.any?
    self.main = true
  end
end
