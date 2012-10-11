require_relative '../../app/presenters/content_image'
require_relative '../../spec/support/content_image_example'
require 'explicit_delegator'

class DummyPresenter < ExplicitDelegator
  include ContentImage

  enforce_definitions :name, :url
end

describe ContentImage do
  let(:presenter) { DummyPresenter }
  include_examples 'content_image'
end
