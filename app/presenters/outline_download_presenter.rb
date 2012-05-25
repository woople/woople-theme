require 'delegate'

class OutlineDownloadPresenter < SimpleDelegator
  def css_class
    if __getobj__.enabled
      "download"
    else
      "download disabled"
    end
  end
end
