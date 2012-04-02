//= require_self
//= require_tree .

function showMobile() {
  var video = $('#video_0_0');
  video.after('<tr><td colspan=3>' + $('#myModal').html());
  var offset = video.offset();
  window.scrollTo(offset.left, offset.top);
}

function showDesktop() {
  $('#myModal').modal();
  $('#myModal').on('hide', function() {
    window.location.href = '/course';
  });
}

$(document).ready(function() {
  if (showingPlayer) {
    if ($(window).width() < 768) {
      showMobile();
    } else {
      showDesktop();
    }
  }
});
