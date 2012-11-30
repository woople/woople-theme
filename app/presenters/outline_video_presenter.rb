require 'action_view/helpers/url_helper'
require 'explicit_delegator'

class OutlineVideoPresenter < ExplicitDelegator
  include ActionView::Helpers::UrlHelper

  enforce_definitions :enabled, :completed, :id, :duration, :url, :name, :description, :now_playing?

  def css_class
    css_classes = []
    css_classes << "disabled" if !video.enabled
    css_classes << "completed" if video.completed

    css_classes.join(" ")
  end

  def slug
    "video_#{video.id}"
  end

  def duration
    minutes   = (video.duration.to_f / 1000.0 / 60.0).floor
    remainder = (video.duration - (minutes * 60 * 1000))
    seconds   = (remainder.to_f / 1000.0).floor

    if seconds <= 9
      seconds = "0#{seconds}"
    end

    "#{minutes}:#{seconds}"
  end

  def url
    if video.enabled
      video.url
    else
      "#"
    end
  end

  def playback_class
    if video.completed
      "icon-ok"
    elsif video.enabled
      "icon-play"
    else
      "icon-lock"
    end
  end

  def playback_icon
    content_tag(:i, nil, class: playback_class)
  end

  def linkable?
    video.completed || video.enabled
  end

  def render_description
    yield(video.description) unless video.description.nil?
  end

  def render_now_playing
    yield if video.now_playing?
  end

  private

  def video
    @delegate
  end
end
