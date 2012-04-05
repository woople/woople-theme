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

  def outline(items, presenter = nil)
    collection = ThemePresentation.wrap_collection(items, OutlinePresenter, presenter)
    render partial: 'woople-theme/outline', collection: collection
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
end
