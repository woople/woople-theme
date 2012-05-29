require 'delegate'
require_relative 'content_image'

class PageHeaderPresenter < SimpleDelegator
  include ContentImage

  def title
    name || header.title
  end

  def image_class
    'page-header-with-image' if has_image?
  end

  def completed_class
    'completed' if header.completed?
  end

  private

  def has_image?
    header.respond_to?(:image)
  end

  def name
    if header.respond_to?(:name)
      header.name
    else
      nil
    end
  end

  def header
    __getobj__
  end
end
