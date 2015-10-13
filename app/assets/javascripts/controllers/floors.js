$(document).ready(function() {
  $('#floors').sortable({
    axis: 'y',
    handle: '.handle',
    update: function() {
        $.post($(this).data('sort-url'), $(this).sortable('serialize'));
    }
  });
});
