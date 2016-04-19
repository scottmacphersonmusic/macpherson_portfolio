$(function() {
  $('#close').click(function() {
    $('.alert-box').fadeOut(300, function() {
      $(this).remove();
    });
  });
});
