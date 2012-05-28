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
    wrapped_assessment = ThemePresentation.wrap(outline.assessment, OutlineAssessmentPresenter)
    view_context.render partial: 'woople-theme/outline_assessment', locals: { assessment: wrapped_assessment }
  end

  private

  def outline
    __getobj__
  end

end
