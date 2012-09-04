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
    render_collection_partial(items, WoopleTheme::Dashboard::CompletedEssentialPresenter, 'dashboard/completed_essential')
  end

  def essentials_exceptions(items)
    render_collection_partial(items, WoopleTheme::Dashboard::EssentialExceptionPresenter, 'dashboard/essential_exception')
  end

  def total_courses(total)
    render partial: 'dashboard/total_courses', locals: {total: total}
  end

  private

  def render_collection_partial(items, presenter, partial)
    collection = ThemePresentation.wrap_collection(items, presenter)
    render partial: partial, collection: collection
  end
end
