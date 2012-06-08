module ThemeHelper
  # This allows you to generate a page-header component
  def page_header(data, presenter = nil)
    data = ThemePresentation.wrap(data, PageHeaderPresenter, presenter)
    render 'woople-theme/page_header', header: data
  end

  def content_items(items, presenter = nil)
    collection = ThemePresentation.wrap_collection(items, ContentItemPresenter, presenter)
    render partial: 'woople-theme/content_item', collection: collection
  end

  def video_modal(video, presenter = nil)
    video = ThemePresentation.wrap(video, presenter)
    render 'woople-theme/video_modal', video: video
  end

  def content_item_header
    render partial: 'woople-theme/content_item_header'
  end

  def outline(item, &block)
    presenter = ThemePresentation.wrap(item, OutlinePresenter)
    presenter.view_context = self

    render partial: 'woople-theme/outline', locals: { outline: presenter, block: block }
  end

  def profile
    if !respond_to?(WoopleTheme.configuration.profile_helper)
      raise "#{WoopleTheme.configuration.profile_helper} helper_method does not exist. WoopleTheme.configuration.profile_helper must point to a valid helper_method."
    end

    model = ThemePresentation.wrap(send(WoopleTheme.configuration.profile_helper), ProfilePresenter)
    render 'woople-theme/profile', profile: model
  end

  def menu
    if !respond_to?(WoopleTheme.configuration.menu_helper)
      raise "#{WoopleTheme.configuration.menu_helper} helper_method does not exist. WoopleTheme.configuration.menu_helper must point to a valid helper_method."
    end

    model = ThemePresentation.wrap(send(WoopleTheme.configuration.menu_helper), MenuPresenter)
    render 'woople-theme/menu', menu: model
  end

  def results_header(title, path = nil)
    output = ""
    output << content_tag(:h2, title, class: 'results-header')
    output << content_tag(:a, I18n.t('woople_theme.search_results_more'), href: path, class: 'loading_indicator') unless path.nil?
    output.html_safe
  end
end
