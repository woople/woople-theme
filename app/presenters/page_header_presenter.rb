class PageHeaderPresenter < SimpleDelegator
  def initialize(header)
    @header = header
    super(header)
  end

  def image(&block)
    yield(@header.image) if @header.image.present?
  end
end
