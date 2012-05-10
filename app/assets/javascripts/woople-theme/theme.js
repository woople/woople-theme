//= require jquery
//= require jquery_ujs
//= require modernizr
//= require spin.min
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

function setLoading(selector, element, options) {
  var div = $('<div></div>').addClass('loadingAction');
  $(element).find(selector).html(div);
  new Spinner(options).spin(div[0]);
}

function visitLocation(element) {
  window.location = $(element).find('a').attr('href');
}

$(document).ready(function() {
  resizeFix();

  if (Modernizr.touch) {
    new FastClick(document.body);
  }

  $('.outline tr').on('click', function() {
    setLoading('td:first-child', this, {
      lines: 9,
      radius: 3,
      length: 4,
      width: 2
    });
    visitLocation(this);
  });

  $('.content-item').on('click', function() {
    setLoading('.content-item-image a', this, {
      width: 3
    });

    visitLocation(this);
  });

});

