require 'delegate'
require_relative 'content_image'

class PageHeaderPresenter < SimpleDelegator
  include ContentImage
end
