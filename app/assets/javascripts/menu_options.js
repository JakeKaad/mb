$(function() {
  $("#menu_item_menu_option_id").change(function() {
    $("#menu_item_course").val(this.selectedOptions[0].dataset.course); 
    $("#menu_item_price_adjustment").val(this.selectedOptions[0].dataset.price);
  });
});
