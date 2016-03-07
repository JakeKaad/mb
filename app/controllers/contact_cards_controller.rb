class ContactCardsController < ApplicationController
  before_action :set_customer

  def new
    authorize! :manage, @customer
    @contact_card = ContactCard.new

    respond_to do |format|
      format.html { redirect_to root_path, alert: "Not supported yet." }
      format.js {}
    end
  end

  def create
    authorize! :manage, @customer
    @contact_card = @customer.contact_cards.new(contact_card_params)
    if @contact_card.save
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Not supported yet." }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Not supported yet." }
        format.js { render :new }
      end
    end
  end

  private

  def set_customer
    @customer = Customer.find params[:customer_id]
  end

  def contact_card_params
    params.require(:contact_card).permit(:phone, :street_address, :address_second_line, :city, :state, :zip, :email)
  end
end
