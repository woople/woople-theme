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

  def video_player(video)
    video = ThemePresentation.wrap(video, WoopleTheme::VideoPresenter)
    render 'woople-theme/video_player', video: video
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

  def results_header title, path
    render partial: 'woople-theme/results_header', locals: { title: title, path: path }
  end

  def impersonation_banner
    if !respond_to?(WoopleTheme.configuration.impersonation_banner_helper)
      raise "#{WoopleTheme.configuration.impersonation_banner_helper} helper_method does not exist. WoopleTheme.configuration.impersonation_banner_helper must point to a valid helper_method."
    end

    model = ThemePresentation.wrap(send(WoopleTheme.configuration.impersonation_banner_helper))

    return unless model.impersonating?

    render 'woople-theme/impersonation_banner', impersonation: model
  end

  def breadcrumb(organization_path)
   render partial: 'woople-theme/breadcrumb',
           object: ThemePresentation.wrap({organization_path: organization_path}, WoopleTheme::BreadcrumbPresenter)
  end

end
