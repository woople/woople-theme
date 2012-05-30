$(document).ready(function() {
  function setFrontHeight(element) {
    var height = element.height();
    element.css({ height: height + 'px' }).attr('data-original-height', height);
  }

  function removeFrontHeight(element) {
    element.css({ height: 'inherit' });
  }

  $('.assessment .flip-action').on('click', function() {
    $(this).closest('.assessment').addClass('flip');

    var front = $(this).closest('.front');
    setFrontHeight(front);

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
    removeFrontHeight(front);
  });
});
