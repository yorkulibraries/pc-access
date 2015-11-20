$(document).ready(function() {

  $("#computer_list").click(function() {
    $(this).hide();
    $("#attach_computer_list_form").removeClass("hide");
    $("#attach_computer_list_form textarea").focus();
  });

  $("#attach_computer_list_form .cancel").click(function() {    
    $("#attach_computer_list_form").addClass("hide");
    $("#computer_list").show();
  });

});
