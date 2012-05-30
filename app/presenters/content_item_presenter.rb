require 'delegate'
require_relative 'content_image'

class ContentItemPresenter < SimpleDelegator
  include ContentImage

  def certification_metadata(&block)
    yield(source.certification_metadata) if source.certification_metadata.present?
  end

  def completed_class
    'completed' if source.completed?
  end

  def source
    __getobj__
  end
end