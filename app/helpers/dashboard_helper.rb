module DashboardHelper
  def status_alert(color, description)
    render partial: 'dashboard/status_alert', object: ThemePresentation.wrap({ color: color, description: description }, WoopleTheme::Dashboard::StatusAlertPresenter)
  end
end
