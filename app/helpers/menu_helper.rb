module MenuHelper
  def menu_option_helper form
    form.select :menu_option_id,
      options_for_select(map_menu_options, include_blank: "Menu Option")
  end


  def map_menu_options
    [["Select option", ""]] + 
    MenuOption.all.map do |mo|
       [mo.name,
        mo.id, {
          'data-price' => mo.suggested_price_adjustment,
          'data-course' => mo.suggested_course
        }]
    end + [["Add a new one", "new"]]
  end
end
