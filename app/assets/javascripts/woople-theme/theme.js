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
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/button
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

function showMobile() {
  var video = $('#good_hands_closing_video_1')
  video.after('<tr><td colspan=3>' + $('#myModal').html());
  var offset = video.offset();
  window.scrollTo(offset.left, offset.top);
}

function showDesktop() {
  $('#myModal').modal();
  $('#myModal').on('hide', function() {
    window.location.href = '/browse/course';
  });
}

$(document).ready(function() {
  prettyPrint();
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

  if (showingPlayer) {
    if ($(window).width() < 768) {
      showMobile();
    } else {
      showDesktop();
    }
  }
});

