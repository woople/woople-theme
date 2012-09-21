//= require_self
//= require_tree .

var showingPlayer;

function showMobile() {
  var modalContents = $('#myModal').html();
  var selectedRow   = $('#video_0_0');
  var playerRow     = selectedRow.after('<tr><td colspan=3>' + modalContents + '</td></tr>');

  $('#myModal').remove();

  var offset = selectedRow.offset();
  window.scrollTo(offset.left, offset.top);

  initPlayer();
}

function showDesktop() {
  $('#myModal').modal();
  $('#myModal').on('hide', function() {
    window.location.href = '/course';
  });

  initPlayer();
}

function playerResizeListener() {
  $(window).bind('resize orientationchange', resizePlayer);
}

function resizePlayer() {
  var parentHeight = $('.modal-video-box').height();
  var parentWidth  = $('.modal-video-box').width();

  $('#theme_video').css({'width': parentWidth, 'height': parentHeight});

  // assume we are parsing a decimal -- http://stackoverflow.com/questions/850341/workarounds-for-javascript-parseint-octal-bug
  $('#theme_video').attr('width', parseInt(parentWidth, 10));
  $('#theme_video').attr('height', parseInt(parentHeight, 10));
}

function initPlayer() {
  jwplayer("theme_video").setup({
    image: '/assets/woople-theme/poster.jpg',
    controlbar: {
      position: 'bottom'
    },
    bufferlength: 10,
    file: videoOptions.desktopSrc,
    height: '100%',
    modes: [{
      type: "flash",
      src: "/assets/jwplayer/player.swf"
    }],
    provider: "video",
    width: '100%',
    plugins: {
      "gapro-2":{}
    }
  });
}

$(document).ready(function() {

  if (showingPlayer) {
    if ($(window).width() < 768) {
      showMobile();
    } else {
      showDesktop();
    }

    playerResizeListener();
    resizePlayer();
  }
});
