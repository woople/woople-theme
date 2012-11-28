//= require_self
//= require_tree .

var showingPlayer;

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
    },{
      type: "html5",
      config: {
        file: videoOptions.mobileSrc
      }
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
    initPlayer();;
  }
});
