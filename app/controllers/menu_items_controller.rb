class MenuItemsController < ApplicationController
  include MenuItemProcessor
  before_action :set_menu

  def create
    process_menu_item @menu, params
    if @menu_item.save
      @menu.increase_price @menu_item.price_adjustment
      flash[:notice] = "#{@menu_item.name} added to menu."
    else
      flash[:alert] = "Something went wrong."
    end

    redirect_back fallback_location: root_path
  end

  private

  def set_menu
    @menu = Menu.find params[:menu_id]
  end
end
