class OutlineVideoPresenter < SimpleDelegator
  def initialize(video)
    super(video)
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

  def video
    __getobj__
  end
end
