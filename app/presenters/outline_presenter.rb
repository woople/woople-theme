class OutlinePresenter < SimpleDelegator
  def initialize(outline)
    super(outline)
  end

  def assessment
    css_class = "assessment"
    css_class << " disabled" if !__getobj__.assessment_enabled?

    yield(css_class) if __getobj__.assessment
  end

  def render_downloads(items, view_context)
    items = ThemePresentation.wrap_collection(items, OutlineDownloadPresenter)
    view_context.render partial: 'woople-theme/outline_download', collection: items
  end

  def render_videos(items, view_context)
    items = ThemePresentation.wrap_collection(items, OutlineVideoPresenter)
    view_context.render partial: 'woople-theme/outline_video', collection: items
  end

end
