$(document).ready(function() {
  function updateAssessmentFormState() {
    var numberOfQuestions = $('#assessment .legend').length;
    var numberOfCheckedAnswers = $('#assessment input:checked').length;
    var numberOfUnansweredQuestions = numberOfQuestions - numberOfCheckedAnswers;

    var unansweredQuestionsBadge = $('#assessment .badge');
    if (numberOfUnansweredQuestions > 0) {
      var unansweredQuestionsBadgeText = numberOfUnansweredQuestions + ' unanswered question';
      if (numberOfUnansweredQuestions > 1) {
        unansweredQuestionsBadgeText += 's';
      }

      unansweredQuestionsBadge.text(unansweredQuestionsBadgeText);
    } else {
      unansweredQuestionsBadge.fadeOut();
      $('#assessment input[type=submit]').removeAttr('disabled');

      $('.touch #assessment .span4').addClass('collapse-height');
    }
  }

  $('#assessment').on('click', 'input[type=radio]', updateAssessmentFormState);

  var cancelButton = $('#assessment input[type=button]');
  cancelButton.click(function() {
    location.href = cancelButton.attr('data-course-path');
  });

  $('.touch #assessment label').click(function() {
    $(this).children('input').attr('checked', 'checked');
    updateAssessmentFormState();
  });
});