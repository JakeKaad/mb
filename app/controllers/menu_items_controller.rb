class MenuItemsController < ApplicationController
  include MenuItemProcessor

  before_action :set_menu

  def create
    authorize! :manage, @menu.event
    process_menu_item @menu, params
    if @menu_item.save
      @menu.increase_price @menu_item.price_adjustment
      flash[:notice] = "#{@menu_item.name} added to menu."
    else
      flash[:alert] = "Something went wrong."
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    authorize! :manage, @menu.event
    @menu_item = MenuItem.find params[:id]
    @menu_item.destroy
    @menu.increase_price -@menu_item.price_adjustment
    redirect_back fallback_location: root_path, alert: "#{@menu_item.name} removed from menu"
  end

  private

  def set_menu
    @menu = Menu.find params[:menu_id]
  end
end
