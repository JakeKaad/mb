class InfosController < ApplicationController
  before_action :require_sign_in
  before_action :set_event
  before_action :set_info, only: [:edit, :update]

  def create
    info = Info.new(info_params)
    info.event = @event
    if info.save
      redirect_to company_event_path(@event.company, @event), notice: "Information added to #{@event.name}."
    else
      handle @event
      render 'events/show', alert: "Something went wrong."
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Not supported."}
      format.js {  }
    end
  end

  def update
    if @info.update(info_params)
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Not supported."}
        format.js {  }
      end
    else
      redirect_to root_path, alert: "Something went wrong."
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def set_info
    @info = Info.find params[:id]
  end

  def info_params
    params.require(:info).permit(
        :linen_colors, :napkin_colors, :napkin_fold, :placesetting, :centerpieces,
        :water_service, :coffee_service, :final_guest_count, :number_of_tables,
        :guests_per_table
      )
  end
end
