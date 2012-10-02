require 'explicit_delegator'
require_relative 'content_image'

class PageHeaderPresenter < ExplicitDelegator
  include ContentImage

  enforce_definitions :description

  def title
    @delegate.name || @delegate.title
  end

  def image_class
    'page-header-with-image' if has_image?
  end

  def completed_class
    'completed' if @delegate.completed?
  end

  private

  def has_image?
    @delegate.respond_to?(:image)
  end

  def name
    if @delegate.respond_to?(:name)
      @delegate.name
    else
      nil
    end
  end
end
