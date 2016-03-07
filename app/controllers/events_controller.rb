class EventsController < ApplicationController

  include EventHandler
  include ContactProcessor
  before_action :require_sign_in
  before_action :set_company

  def show
    @event = Event.find params[:id]
    authorize! :read, @event
    event_details @event
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
    contact_processor = create_contact_processor
    if @event.save && contact_processor.add_primary_contact_to?(@event)
      render_contact contact_processor
      redirect_to company_event_path(@company, @event), notice: "Event was added succesfully."
    else
      flash[:alert] =  "Something went wrong, event not created."
      render :new
    end
  end

  private

  def create_contact_processor
    cp = ContactProcessor.new(
      customer_params: primary_contact_attributes,
      contact_params: contact_card_params
    )
  end

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
