$(document).ready(function() {
  $('#assessment').on('click', 'input[type=radio]', function() {
    var numberOfQuestions = $('#assessment legend').length;
    var numberOfCheckedAnswers = $('#assessment input:checked').length;
    var numberOfUnansweredQuestions = numberOfQuestions - numberOfCheckedAnswers;

    var unansweredQuestionsBadge = $('#assessment .badge');
    if (numberOfUnansweredQuestions > 0) {
      var unansweredQuestionsBadgeText = numberOfUnansweredQuestions + ' unanswered question';
      if (numberOfUnansweredQuestions > 1) {
        unansweredQuestionsBadgeText = unansweredQuestionsBadgeText + 's'
      }

      unansweredQuestionsBadge.text(unansweredQuestionsBadgeText);
    } else {
      unansweredQuestionsBadge.fadeOut();
      $('#assessment input[type=submit]').removeAttr('disabled');
    }
  });

  $('input[type=button]').click(function() {
    history.back();
  });
});