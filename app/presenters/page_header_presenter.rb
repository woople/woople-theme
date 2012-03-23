class PageHeaderPresenter < SimpleDelegator
  include ContentImage

  def initialize(header)
    super(header)
  end
end
