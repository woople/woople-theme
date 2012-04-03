require_relative '../../app/presenters/content_image'
require_relative '../../spec/support/content_image_example'
require 'delegate'

class DummyPresenter < SimpleDelegator
  include ContentImage
end

describe ContentImage do
  let(:presenter) { DummyPresenter }
  include_examples 'content_image'
end

