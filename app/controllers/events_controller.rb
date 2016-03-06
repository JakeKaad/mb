class EventsController < ApplicationController

  include EventHandler
  before_action :require_sign_in
  before_action :set_company

  def show
    @event = Event.find params[:id]

    authorize! :read, @event
    handle @event
  end

  def new
    @event = Event.new company_id: @company.id
    @primary_contact = Customer.new
    @contact_card = ContactCard.new
    @event.primary_contact = @primary_contact
    authorize! :create, @event
  end

  def create
    @event = @company.events.new(event_params)
    authorize! :create, @event
    @primary_contact = Customer.find_or_create_by(email: primary_contact_attributes["email"])  
    @primary_contact.update(primary_contact_attributes)
    @contact_card = @primary_contact.contact_cards.create(contact_card_params)

    if @event.save && @event.add_primary?(@primary_contact)
      redirect_to company_event_path(@company, @event), notice: "Event was added succesfully."
    else
      flash[:alert] =  "Something went wrong, event not created."
      render :new
    end
  end

  private

  def set_company
    @company = Company.find params[:company_id]
  end

  def primary_contact_attributes
    params[:event].require(:primary_contact_attributes).permit(:first_name, :last_name, :password, :email)
  end

  def contact_card_params
    params[:event].require(:contact_card).permit(:phone, :street_address, :address_second_line, :city, :state, :zip)
  end

  def event_params
    params.require(:event).permit(:date, :name, :start_time, :room_id)
  end
end
