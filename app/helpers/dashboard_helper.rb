module DashboardHelper
  def status_alert(color, description)
    render partial: 'dashboard/status_alert',
           object: ThemePresentation.wrap({ color: color, description: description }, WoopleTheme::Dashboard::StatusAlertPresenter)
  end

  def essentials_section(presenter)
    render partial: 'dashboard/essentials_section',
           object: ThemePresentation.wrap(presenter, WoopleTheme::Dashboard::EssentialsSectionPresenter)
  end

  def essentials_completed(items)
    render_collection_partial(items, WoopleTheme::Dashboard::EssentialCompletedPresenter, 'woople-theme/content_item')
  end

  def essentials_exceptions(items)
    render_collection_partial(items, WoopleTheme::Dashboard::EssentialExceptionPresenter, 'dashboard/exception')
  end

  def electives_section(presenter)
    render partial: 'dashboard/electives_section',
           object: ThemePresentation.wrap(presenter, WoopleTheme::Dashboard::ElectivesSectionPresenter)
  end

  def electives_history(items)
    render_collection_partial(items, WoopleTheme::Dashboard::ElectiveHistoryPresenter, 'woople-theme/content_item')
  end

  def electives_exceptions(items)
    render_collection_partial(items, WoopleTheme::Dashboard::ElectiveExceptionPresenter, 'dashboard/exception')
  end

  private

  def render_collection_partial(items, presenter, partial)
    collection = ThemePresentation.wrap_collection(items, presenter)
    render partial: partial, collection: collection
  end
end
