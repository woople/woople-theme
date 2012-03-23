class ContentItemPresenter < SimpleDelegator
  include ContentImage

  def initialize(content_item)
    super(content_item)
  end

  def certification_metadata(&block)
    yield(source.certification_metadata) if source.certification_metadata.present?
  end

  def source
    __getobj__
  end
end
