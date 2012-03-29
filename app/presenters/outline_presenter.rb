class OutlinePresenter < SimpleDelegator
  def initialize(outline)
    super(outline)
  end

  def assessment
    css_class = "assessment"
    css_class << " disabled" if !__getobj__.assessment_enabled?

    yield(css_class) if __getobj__.assessment
  end

  def decorate_download(download)
    OutlineDownloadPresenter.new(download)
  end

  def decorate_video(video)
    OutlineVideoPresenter.new(video)
  end
end
