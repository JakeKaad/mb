class MenuItemsController < ApplicationController
  before_action :set_menu

  def create
    process_menu_item

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

    ## TODO move this into a service class
    
    def process_menu_item
      if menu_option_params?
        create_menu_option if menu_option_params?
        build_item_from_option
      else
        @menu_item = @menu.menu_items.new(menu_item_params)
      end
    end

    def build_item_from_option
      @menu_item = @menu.menu_items.new(course: @option.suggested_course,
                           price_adjustment: @option.suggested_price_adjustment,
                           menu_option_id: @option.id)
    end

    def create_menu_option
      @option = MenuOption.create(menu_option_params)
    end

    def menu_option_params
      params.require(:menu_item).require(:menu_option).permit(:name, :suggested_course, :suggested_price_adjustment, :cuisine)
    end

    def menu_option_params?
      params[:menu_item][:menu_option].present?
    end
end
