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

function paginationLoading(element, options) {
  var spinner = new Spinner(options).spin();
  var el      = $(element);
  var span    = $('<span></span>').addClass('loading');

  span.css({ 'width': el.width() });

  el.html(span);
  $( spinner.el ).css({'top': '50%', 'left': '50%' });
  span.append(spinner.el);
}

function visitLocation(element, newWindow) {
  var url = $(element).find('a').attr('href');

  if (newWindow) {
    window.open(url, "_blank");
  } else {
    window.location = url;
  }
}

$(document).ready(function() {
  resizeFix();

  if (Modernizr.touch) {
    new FastClick(document.body);
  }

  $('.outline tr').not('.disabled').on('click', function(e) {
    e.preventDefault();

    setLoading('td:first-child', this, {
      lines:  9,
      radius: 3,
      length: 4,
      width:  2
    });

    visitLocation(this, $(this).hasClass('download'));
  });

  $('.content-item').on('click', function() {
    setLoading('.content-item-image a', this, {
      width: 3
    });
    visitLocation(this);
  });

  $('.pagination a').on('click', function() {
    paginationLoading(this, {
      lines:  9,
      radius: 2,
      length: 2,
      width:  2
    });
  });

});
