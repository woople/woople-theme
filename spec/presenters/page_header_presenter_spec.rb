require_relative '../../app/presenters/page_header_presenter'
require_relative '../../spec/support/content_image_example'

describe PageHeaderPresenter do
  let(:presenter) { PageHeaderPresenter }
  include_examples 'content_image'
end
