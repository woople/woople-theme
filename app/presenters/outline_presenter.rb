class OutlinePresenter < SimpleDelegator
  def initialize(outline)
    super(outline)
  end

  def assessment
    css_class = "assessment"
    css_class << " disabled" if !__getobj__.assessment_enabled?

    yield(css_class) if __getobj__.assessment
  end

  def render_downloads(items)
    items = ThemePresentation.wrap_collection(items, OutlineDownloadPresenter)
    render partial: 'woople-theme/outline_download', collection: items
  end

  def render_videos(items)
    items = ThemePresentation.wrap_collection(items, OutlineVideoPresenter)
    render partial: 'woople-theme/outline_video', collection: items
  end

end
