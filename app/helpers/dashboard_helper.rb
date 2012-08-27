module DashboardHelper
  def status_alert(color, description)
    render partial: 'dashboard/status_alert',
           object: ThemePresentation.wrap({ color: color, description: description }, WoopleTheme::Dashboard::StatusAlertPresenter)
  end

  def essentials_section(presenter)
    render partial: 'dashboard/essentials_section',
           object: ThemePresentation.wrap(presenter, WoopleTheme::Dashboard::EssentialsSectionPresenter)
  end

end
