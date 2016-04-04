class MenuItemsController < ApplicationController
  before_action :set_menu


  def create
    @menu_item = @menu.menu_items.new(menu_item_params)
    
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

    def menu_item_params
      params.require(:menu_item).permit(:menu_option_id, :course, :price_adjustment)
    end
end
