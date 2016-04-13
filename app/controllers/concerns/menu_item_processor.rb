module MenuItemProcessor
  extend ActiveSupport::Concern

  included do
    class MenuItemProcessor
      attr_accessor :params, :menu_option, :menu_item, :menu

      def initialize(menu, params)
        @menu = menu
        @params = params
        process
      end

      private

      def process
        if menu_option_params?
          create_menu_option if menu_option_params?
          build_item_from_option
        else
          @menu_item = @menu.menu_items.new(menu_item_params)
        end
      end

      def build_item_from_option
        @menu_item = @menu.menu_items.new(course: menu_option.suggested_course,
                             price_adjustment: menu_option.suggested_price_adjustment,
                             menu_option_id: menu_option.id)
      end

      def create_menu_option
        @menu_option = MenuOption.create(menu_option_params)
      end

      def menu_item_params
        params.require(:menu_item).permit(:menu_option_id, :course, :price_adjustment)
      end

      def menu_option_params
        params.require(:menu_item).require(:menu_option).permit(:name, :suggested_course, :suggested_price_adjustment, :cuisine)
      end

      def menu_option_params?
        params[:menu_item][:menu_option].present? && params[:menu_item][:menu_option][:name].present?
      end
    end
  end

  def process_menu_item menu, params
    @menu_item_processor ||= MenuItemProcessor.new menu, params
    @menu_item ||= @menu_item_processor.menu_item
    @menu_option ||= @menu_item_processor.menu_option
  end
end
