$(document).on("turbolinks:load", function() {
  $("#menu_item_menu_option_id").change(function() {
    if(this.value === "new") {
      $("#options_form_hidden").css("display", "block");
      $("#menu_item_course_group").hide();
      $("#menu_item_price_adjustment_group").hide();
    } else {
      $("#options_form_hidden").css("display", "none");
      $("#menu_item_course_group").show();
      $("#menu_item_price_adjustment_group").show();
      $("#menu_item_course").val(this.selectedOptions[0].dataset.course);
      $("#menu_item_price_adjustment").val(this.selectedOptions[0].dataset.price);
    }
  });
});
