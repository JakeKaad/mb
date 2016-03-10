class ContactCardsController < ApplicationController
  before_action :set_customer
  before_action :set_contact_card, only: [:edit, :update]

  def new
    authorize! :manage, @customer
    @contact_card = ContactCard.new

    respond_to do |format|
      format.html { not_supported }
      format.js {}
    end
  end

  def create
    authorize! :manage, @customer
    @contact_card = @customer.contact_cards.new(contact_card_params)
    if @contact_card.save
      respond_to do |format|
        format.html { not_supported }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { not_supported }
        format.js { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html { not_supported }
      format.js {}
    end
  end

  def update
    if @contact_card.update(contact_card_params)
      respond_to do |format|
        format.html { not_supported }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { not_supported }
        format.js { render :edit }
      end
    end
  end

  private

  def set_customer
    @customer = Customer.find params[:customer_id]
  end

  def set_contact_card
    @contact_card = ContactCard.find params[:id]
  end

  def contact_card_params
    params.require(:contact_card).permit(:phone, :street_address, :address_second_line, :city, :state, :zip, :email)
  end
end
