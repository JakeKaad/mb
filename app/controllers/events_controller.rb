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
    @event.primary_contact = @primary_contact
    authorize! :create, @event
  end

  def create
    @event = @company.events.new(event_params)
    authorize! :create, @event
    @primary_contact = Customer.first_or_create(primary_contact_attributes)

    if @event.save
      @event.primary_contact = @primary_contact
      Booking.create(event_id: @event.id, customer_id: @event.primary_contact.id, company_id: @company.id)
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
    attributes = {}
    attrs = params[:event][:primary_contact_attributes]
    attributes[:first_name] = attrs["first_name"]
    attributes[:last_name] = attrs["last_name"]
    attributes[:password] = attrs["password"]
    attributes[:email] = attrs["email"]
    attributes
  end

  def event_params
    params.require(:event).permit(:date, :name, :start_time, :room_id)
  end
end
