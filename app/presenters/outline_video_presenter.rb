require 'delegate'

class OutlineVideoPresenter < SimpleDelegator
  REQUIRED_ATTRIBUTES = [:enabled, :completed, :id, :duration, :url, :name]

  def initialize(video)
    super(video)
    check_attributes
  end

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
    minutes = (video.duration.to_f / 1000.0 / 60.0).floor
    remainder = (video.duration - (minutes * 60 * 1000))
    seconds = (remainder.to_f / 1000.0).floor

    if seconds <= 9
      seconds = "0#{seconds}"
    end

    "#{minutes}:#{seconds}"
  end

  def completed
    yield if video.completed
  end

  def url
    if video.enabled
      video.url
    else
      "#"
    end
  end

  private

  def check_attributes
    raise "Rendering a video requires: #{missing_attributes}" if missing_attributes?
  end

  def missing_attributes?
    REQUIRED_ATTRIBUTES.find do |attr|
      !__getobj__.respond_to?(attr)
    end
  end

  def missing_attributes
    REQUIRED_ATTRIBUTES.select do |attr|
      !__getobj__.respond_to?(attr)
    end
  end

  def video
    __getobj__
  end
end
