require 'action_view'
require 'delegate'

class OutlinePresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper

  attr_accessor :view_context

  def name
    content_tag(:h2, outline.name)
  end

  def videos(videos = outline.videos)
    wrapped_videos = ThemePresentation.wrap_collection(videos, OutlineVideoPresenter)
    view_context.render partial: 'woople-theme/outline_videos', locals: { videos: wrapped_videos }
  end

  def downloads(downloads = outline.downloads)
    wrapped_downloads = ThemePresentation.wrap_collection(downloads, OutlineDownloadPresenter)
    view_context.render partial: 'woople-theme/outline_downloads', locals: { downloads: wrapped_downloads }
  end

  def assessment
    view_context.render partial: 'woople-theme/outline_assessment', locals: { outline: self, assessment: outline.assessment }
  end

  def render_assessment
    css_class = "assessment"
    css_class << " disabled" if assessment_disabled?

    yield(css_class) if has_assessment?
  end

  private

  def assessment_disabled?
    outline.respond_to?(:assessment_enabled) && !outline.assessment_enabled
  end

  def has_assessment?
    outline.respond_to?(:assessment) && outline.assessment
  end

  def outline
    __getobj__
  end

end
