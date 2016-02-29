class EventsController < ApplicationController
  before_action :set_company

  def show
    @event = Event.find params[:id]
    event_meta = handle @event
    @info = event_meta.info
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

  def handle event
    EventHandler.new event
  end

  class EventHandler
    attr_reader :info
    attr_accessor :event

    def initialize(event)
      @event = event
      find_info event
    end

    private

    def find_info event
      if event.info.present?
        @info = event.info
      else
        @info = Info.new event: event
      end
    end
  end
end
