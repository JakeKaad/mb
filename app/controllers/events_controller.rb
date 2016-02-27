class EventsController < ApplicationController

  def show
    @company = Company.find params[:company_id]
    @event = Event.find params[:id]
  end
end
