$(function() {
  if (!phone()) {
    $('#organization-accounts').popover({
      selector: '.status-alert',
      placement: 'top',
      template: '<div class="popover status-popover"><div class="arrow"></div><div class="popover-inner"><div class="popover-content"><p></p></div></div></div>'
    });
  }

  $('#organization-accounts button').click(function() {
    alert('Coming soon!');
  });

  if (phone()) {
    $('#organization-accounts button').addClass('btn-large');
  }
});
