class MenusController < ApplicationController
  before_action :set_event

  def create
    @menu = Menu.new(event: @event)
    if @menu.update(menu_params)
      flash[:notice] = "Menu info added to #{@event.name}."
    else
      flash[:alert] = "Menu info not saved."
    end
    redirect_to company_event_path(@event.company, @event, event_tab: "menu")
  end

  private

    def set_event
      @event = Event.find params[:event_id]
    end

    def menu_params
      params.require(:menu).permit(:service_style, :rate_type, :base_rate)
    end
end
