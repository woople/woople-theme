$(function() {
  if ($('#organization-accounts')) new OrganizationDashboardController().init();
});

(function(){
  function OrganizationDashboardController() {}

  OrganizationDashboardController.prototype.init = function(debugMode) {
    this.debugMode = debugMode !== null ? debugMode : false;
    this.setupListeners();

    this.log('initialize');
  };

  OrganizationDashboardController.prototype.setupListeners = function() {
    this.log('setup listeners');

    this.mobileSetup();
    this.bindReminderButtons();
  };

  OrganizationDashboardController.prototype.mobileSetup = function() {
    if (this.isPhone()) {
      $('#organization-accounts button').addClass('btn-large');
    } else {
      this.createPopover();
    }
  };

  OrganizationDashboardController.prototype.createPopover = function() {
    $('#organization-accounts').popover({
      selector: '.status-alert',
      placement: 'top',
      template: '<div class="popover status-popover"><div class="arrow"></div><div class="popover-inner"><div class="popover-content"><p></p></div></div></div>'
    });
  };

  OrganizationDashboardController.prototype.bindReminderButtons = function() {
    this.log('bind reminder button events');

    var reminderClick = function(reminderPath, button) {
      this.log('fire reminder callback');
      this.sendReminder(reminderPath, button);
    };

    var clickBinder = function(button){
      var reminderPath          = $(button).data('reminder-path');
      var debouncedClickHandler = _.debounce(reminderClick, 300); // avoid button click spamming.
      var boundClickHandler     = _.bind(debouncedClickHandler, this, reminderPath, button);
      $(button).click(boundClickHandler);
    };

    var buttons = $('#organization-accounts .remind-column .btn');
    _.each(buttons, clickBinder , this);
  };

  OrganizationDashboardController.prototype.sendReminder = function(reminderPath, button) {
    $(button).prop('disabled', true);
    $.ajax({
      type    : 'POST',
      url     : reminderPath,
      context : button,
      success : this.changeButton,
      error   : this.remindError
    });
  };

  OrganizationDashboardController.prototype.changeButton = function(data, textStatus, jqXHR) {
    $(this).addClass('btn-success sent');
  };

  OrganizationDashboardController.prototype.remindError = function(jqXHR, textStatus, errorThrown) {
    alert($(this).data('errorMessage'));
    $(this).prop('disabled', false);
  };

  OrganizationDashboardController.prototype.log = function(message) {
    if (this.debugMode !== true) return;
    console.log("[OrganizationDashboardController]", message);
  };

  OrganizationDashboardController.prototype.isPhone = function() {
    return this.windowWidth() <= 480 ? true : false;
  };

  OrganizationDashboardController.prototype.windowWidth = function() {
    return $(window).width();
  };

  this.OrganizationDashboardController = OrganizationDashboardController;

})(this);
