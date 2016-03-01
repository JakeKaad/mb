class InfosController < ApplicationController
  before_action :require_sign_in
  before_action :set_event

  def create
    info = Info.new(event: @event)
    if info.save(info_params)
      redirect_to company_event_path(@event.company, @event), notice: "Information added to #{@event.name}."
    else
      handle @event
      render 'events/show', alert: "Something went wrong."
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def info_params
    params.require(:info).permit(
        :linen_colors, :napkin_colors, :napkin_fold, :placesetting, :centerpieces,
        :water_service, :coffee_service, :final_guest_count, :number_of_tables,
        :guests_per_table
      )
  end
end
