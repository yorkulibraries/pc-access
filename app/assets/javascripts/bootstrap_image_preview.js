$(document).ready(function(){
  $(".image_preview").css("cursor", "pointer");
  $(".image_preview").click(function() {
    bootstrap_image_preview($(this).data("full-size-path"));
  });
});
function  bootstrap_image_preview(image_path) {
  // clear out existing stuff
  $( '.modal-backdrop' ).remove();
  $(".bootstrap_image_preview_holder #bootstrap_image_preview_modal").modal('hide');
  $(".bootstrap_image_preview_holder").remove();


  var holder = $("<div/>").addClass("bootstrap_image_preview_holder");
  var modal = $("<div/>").addClass("modal").attr("id", "bootstrap_image_preview_modal");

  var modal_dialog = $("<div/>").addClass("modal-dialog").addClass("modal-lg").attr("role", "document");
  var modal_content = $("<div/>").addClass("modal-content");
  var modal_header = $("<div/>").addClass("modal-header");
  var modal_body = $("<div/>").addClass("modal-body");

  var image = $("<img/>").attr("src", image_path);

  var close_button = $("<button/>").attr("data-dismiss", "modal").attr("type", "button").addClass("close");
  close_button.append("<span class='fa fa-close'></span>");

  modal_header.append(close_button);
  modal_header.append("<h4 class='modal-title'>Fulle Image Preview</h4>");


  modal_body.append(image);
  modal_content.append(modal_header);
  modal_content.append(modal_body);

  modal_dialog.append(modal_content);
  modal.append(modal_dialog);
  holder.append(modal);

  $("body").append(holder);
  $("#bootstrap_image_preview_modal").modal('show');

}
