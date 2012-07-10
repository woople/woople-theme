//= require jquery
//= require jquery_ujs
//= require modernizr
//= require spin.min
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/button
//= require twitter/bootstrap/alert
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

function tinyLoadingIndicator(element) {
  options = {
    lines:  9,
    radius: 2,
    length: 2,
    width:  2
  };

  var spinner = new Spinner(options).spin();
  var el      = $(element);
  var span    = $('<span></span>').addClass('loading');

  span.css({ 'width': el.width() });

  el.html(span);
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

function mobileSearchToggle() {
  var mobileSearch = $('<div></div>').addClass('mobile-search');

  $('a.search-page').on('click', function(e) {
    e.preventDefault();
    
    var masthead        = $('#masthead');
    var menu            = $('.container .menu');
    var form            = $('form.search');
    var profile         = $('.profile');

    var clonedForm      = form.clone(true);

    masthead.toggleClass('mobile-search-visible');
    menu.toggleClass('mobile-search-visible');

    $(clonedForm).children('a').remove();

    if ($(mobileSearch).is(":visible")) {
      mobileSearch.empty();
      mobileSearch.hide();
    } else {
      mobileSearch.html(clonedForm);
      mobileSearch.show();
      $(profile).before(mobileSearch);
    }

    return false;
  });

}

function phone() {
  return $(window).width() <= 480 ? true : false;
}

$(document).ready(function() {
  resizeFix();

  if (Modernizr.touch) {
    new FastClick(document.body);
  }

  $('.outline tbody tr').not('.disabled').on('click', function(e) {
    e.preventDefault();

    if (!$(this).hasClass('download')) {
      setLoading('td:first-child', this, {
        lines:  9,
        radius: 3,
        length: 4,
        width:  2
      });
    }

    visitLocation(this, $(this).hasClass('download'));
  });

  $('.content-item').on('click', function() {
    setLoading('.content-item-image a', this, {
      width: 3
    });
    visitLocation(this);
  });

  $('.pagination a').on('click', function() {
    tinyLoadingIndicator(this);
  });

  $('a.loading_indicator').on('click', function() {
    tinyLoadingIndicator(this);
  });

  mobileSearchToggle();
});
