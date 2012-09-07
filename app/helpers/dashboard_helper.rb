module DashboardHelper
  def status_alert(color, description)
    render partial: 'dashboard/status_alert',
           object: ThemePresentation.wrap({ color: color, description: description }, WoopleTheme::Dashboard::StatusAlertPresenter)
  end

  def essentials_section(presenter)
    render partial: 'dashboard/essentials_section',
           object: ThemePresentation.wrap(presenter, WoopleTheme::Dashboard::EssentialsSectionPresenter)
  end

  def electives_section(presenter)
    render partial: 'dashboard/electives_section',
           object: ThemePresentation.wrap(presenter, WoopleTheme::Dashboard::ElectivesSectionPresenter)
  end

  def completed_essentials(items)
    collection = ThemePresentation.wrap_collection(items, WoopleTheme::Dashboard::CompletedEssentialPresenter)
    render partial: 'dashboard/completed_essential', collection: collection
  end

  def total_courses(total)
    render partial: 'dashboard/total_courses', locals: {total: total}
  end

end
