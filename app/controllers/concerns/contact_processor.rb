module ContactProcessor
  extend ActiveSupport::Concern

  included do
    class ContactProcessor
      attr_accessor :customer_params, :contact_params, :event, :email

      def initialize(customer_params: , contact_params: )
        @customer_params = customer_params
        @contact_params = contact_params
        set_email
      end

      def primary_contact
        @primary_contact ||= Customer.find_or_create_by(email: email)
      end

      def main_card
        @contact_card ||= primary_contact.contact_cards.find_or_create_by(email: email)
      end

      def add_primary_contact_to? event
        @event = event
        primary_contact.update(customer_params)
        main_card.update(contact_params)
        event.add_primary? primary_contact
      end

      def all_valid?
        primary_contact.valid? && main_card.valid? && event.valid?
      end

      private

      def set_email
        @email = customer_params[:email]
        contact_params[:email] = email
      end
    end
  end

  def render_contact processor
    @primary_contact ||= processor.primary_contact
    @contact_card ||= processor.main_card
  end
end
