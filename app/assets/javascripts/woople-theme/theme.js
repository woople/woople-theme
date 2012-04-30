//= require jquery
//= require jquery_ujs
//= require modernizr
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/button
//= require fastclick.min_
//= require video.min
//= require_tree .

function resizeFix() {
  if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
    var viewportmeta = document.querySelector('meta[name="viewport"]');
    if (viewportmeta) {
      viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0';
      document.body.addEventListener('gesturestart', function () {
        viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
      }, false);
    }
  }
}


$(document).ready(function() {
  resizeFix();

  if (Modernizr.touch) {
    new FastClick(document.body);
  }

  $('.touch .content-item').on('click', function() {
    window.location = $(this).find('a').attr('href');
  });

  $('.touch .outline tr').on('click', function(e) {
    window.location = $(this).find('a').attr('href');
  });

});

