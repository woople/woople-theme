require 'delegate'
require_relative 'content_image'

class PageHeaderPresenter < SimpleDelegator
  include ContentImage

  def title
    name || header.title
  end

  private

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
