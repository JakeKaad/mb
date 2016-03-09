class CustomersController < ApplicationController
  include ContactProcessor

  before_action :set_event


  def new
    authorize! :manage, @event
    @customer = Customer.new
    @contact_card = ContactCard.new
    respond_to do |format|
      format.html { not_supported }
      format.js {}
    end
  end

  def create
    authorize! :manage, @event
    cp = ContactProcessor.new(customer_params: customer_params, contact_params: contact_card_params)
    if cp.add_customer_to? @event
      @customers = @event.customers
      respond_to do |format|
        format.html { not_supported }
        format.js {}
      end
    else
      @customer = cp.customer
      respond_to do |format|
        format.html { not_supported }
        format.js { render :new }
      end
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :password, :email)
  end

  def contact_card_params
    params[:customer].require(:contact_card).permit(:phone, :street_address, :address_second_line, :city, :state, :zip)
  end
end
