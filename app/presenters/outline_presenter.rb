require 'delegate'

class OutlinePresenter < SimpleDelegator
  def assessment
    css_class = "assessment"
    css_class << " disabled" if assessment_disabled?

    yield(css_class) if has_assessment?
  end

  def render_downloads(view_context)
    wrapped_downloads = ThemePresentation.wrap_collection(downloads, OutlineDownloadPresenter)
    view_context.render partial: 'woople-theme/outline_download', collection: wrapped_downloads
  end

  def render_videos(view_context)
    wrapped_videos = ThemePresentation.wrap_collection(videos, OutlineVideoPresenter)
    view_context.render partial: 'woople-theme/outline_video', collection: wrapped_videos
  end

  private

  def downloads
    outline.downloads
  end

  def videos
    outline.videos
  end

  def assessment_disabled?
    outline.respond_to?(:assessment_enabled?) && !outline.assessment_enabled?
  end

  def has_assessment?
    outline.respond_to?(:assessment) && outline.assessment
  end

  def outline
    __getobj__
  end

end
