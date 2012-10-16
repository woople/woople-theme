(function(){
   function OrganizationDashboardController(options) {
      this.debugMode       = false;

      this.reminderCallback = options.reminderCallback;
      this.setupListeners();
  }

  OrganizationDashboardController.prototype.setupListeners = function() {
    this.log('setup listeners');

    this.mobileSetup();
    this.bindReminderButtons();
  };

  OrganizationDashboardController.prototype.mobileSetup = function() {
    if (this.isPhone()) {
      $('#organization-accounts button').addClass('btn-large');
    } else {
      $('#organization-accounts').popover({
        selector: '.status-alert',
        placement: 'top',
        template: '<div class="popover status-popover"><div class="arrow"></div><div class="popover-inner"><div class="popover-content"><p></p></div></div></div>'
      });
    }
  };

  OrganizationDashboardController.prototype.bindReminderButtons = function() {
    this.log('bind reminder button events');

    var reminderClick = function(userId) {
      this.log('fire reminder callback');
      this.reminderCallback(userId);
    };

    var clickBinder = function(button){
      var userId = $(button).data('userId');
      $(button).click(_.bind(reminderClick, this, userId));
    };

    var buttons = $('#organization-accounts .remind-column .btn');
    _.each(buttons, clickBinder , this);
  };

  OrganizationDashboardController.prototype.log = function(message) {
    if (!this.debugMode) return;
    console.log("[OrganizationDashboardController]", message);
  };

  OrganizationDashboardController.prototype.isPhone = function() {
    return $(window).width() <= 480 ? true : false;
  };

  this.OrganizationDashboardController = OrganizationDashboardController;

})(this);
