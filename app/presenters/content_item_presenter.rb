require 'explicit_delegator'

require_relative 'content_image'

class ContentItemPresenter < ExplicitDelegator
  include ContentImage

  enforce_definitions :name, :url

  def render_time_remaining(&block)
    yield(source.time_remaining, source.time_total)
  end

  def render_popularity(&block)
    yield(source.popularity)
  end

  def render_certification_metadata(&block)
    yield(source.certification_metadata) if source.certification_metadata.present?
  end

  def render_progress_bar(&block)
    yield(source.percent_complete) if source.percent_complete.present?
  end

  def render_completed_on(&block)
  end

  def render_elective_points(&block)
  end

  def render_essential_duration(&block)
  end

  def completed_class
    'completed' if source.completed?
  end

  private

  def source
    @delegate
  end
end
