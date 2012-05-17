$(document).ready(function() {
  function setFrontHeight() {
    var element = $(this);
    var height = element.height();
    element.css({ height: height + 'px' }).attr('data-original-height', height);
  }

  $('.assessment .front').each(setFrontHeight);

  $('.assessment .flip-action').on('click', function() {
    $(this).closest('.assessment').addClass('flip');

    var front = $(this).closest('.front');
    var frontHeight = front.height();

    var back = $(this).closest('.front').next('.back');
    var backHeight = back.height();

    if (frontHeight > backHeight) {
      back.css({ height: '100%' });
    } else {
      front.css({ height: backHeight + 'px' });
    }
  });

  $('.assessment .flip-action-back').on('click', function() {
    var assessment = $(this).closest('.assessment').removeClass('flip');
    var front = assessment.find('.front');
    front.css({ height: front.attr('data-original-height') + 'px' });
  });

  $('.assessment .alert').bind('closed', function() {
    var front = $(this).closest('.assessment .front');

    front.css({ height: 'initial' });
    setTimeout(function() {
      setFrontHeight.call(front);
    }, 100);
  });
});
