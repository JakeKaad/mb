class CustomersController < ApplicationController
  before_action :set_event

  def new
    @customer = Customer.new
    respond_to do |format|
      format.html { not_supported }
      format.js {}
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end
end
