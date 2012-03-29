class OutlineDownloadPresenter < SimpleDelegator
  def initialize(download)
    super(download)
  end

  def css_class
    "disabled" if !__getobj__.enabled
  end
end
