module InfoMacros
  def fill_in_info_params info=nil
    info ||= build :info
    fill_in "Linen colors", with: info.linen_colors
    fill_in "Napkin colors", with: info.napkin_colors
    fill_in "Napkin fold", with: info.napkin_fold
    fill_in "Placesetting", with: info.placesetting
    fill_in "Centerpieces", with: info.centerpieces
    fill_in "Water service", with: info.water_service
    fill_in "Coffee service", with: info.coffee_service
    fill_in "Final guest count", with: info.final_guest_count
    fill_in "Number of tables", with: info.number_of_tables
    fill_in "Guests per table", with: info.guests_per_table
  end
end
