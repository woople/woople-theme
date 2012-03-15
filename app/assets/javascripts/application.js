// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require modernizr
//= require google-code-prettify/prettify
//= require twitter/bootstrap/dropdown
//= require fastclick.min_
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


/*
   This is a dirty hack.
   On safari when you open the menu and close it the transform
   makes the page think that it is bigger than it really is
   in order to resolve it you need to re-render the page
*/
function dirtyHack() {
  $('.close').on('click', function() {
    $('body > .container').width($(document).width() - 1);
    setTimeout(function() {
      $('body > .container').removeAttr('style');
    }, 500);
  });
}

$(document).ready(function() {
  prettyPrint();
  resizeFix();
  dirtyHack();
  new FastClick(document.body);

  $('.touch .content-item').on('click', function() {
    window.location = $(this).find('a').attr('href');
  });
});

