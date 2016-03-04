class EventsController < ApplicationController

  include EventHandler
  before_action :require_sign_in
  before_action :set_company

  def show
    @event = Event.find params[:id]
    handle @event
  end

  def new
    @event = Event.new
  end

  def create
    @event = @company.events.new(event_params)
    if @event.save
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

  def event_params
    params.require(:event).permit(:date, :name, :start_time, :room_id)
  end
end
