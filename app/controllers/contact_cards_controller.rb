class ContactCardsController < ApplicationController

  def new
    @customer = Customer.find params[:customer_id]
    @contact_card = ContactCard.new

    respond_to do |format|
      format.html { redirect_to root_path, alert: "Not supported yet." }
      format.js {}
    end
  end
end
