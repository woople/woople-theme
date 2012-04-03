require 'delegate'

class OutlineDownloadPresenter < SimpleDelegator
  def css_class
    "disabled" if !__getobj__.enabled
  end
end
