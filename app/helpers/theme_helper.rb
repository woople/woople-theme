module ThemeHelper

  # This allows you to generate a page-header component
  def page_header(header, presenter = nil)
    #TODO: fix this hack
    if header.is_a? Hash
      header = OpenStruct.new(header)
    end

    if presenter.present?
      header = presenter.new(header)
    end

    render 'woople-theme/page_header', header: PageHeaderPresenter.new(header)
  end

  def content_items(items, presenter = nil)
    if presenter.present?
      collection = items.collect { |item| ContentItemPresenter.new(presenter.new(item)) }
    else
      collection = items.collect { |item| ContentItemPresenter.new(item) }
    end

    render partial: 'woople-theme/content_item', collection: collection
  end

  def video_modal(video, presenter = nil)
    if presenter.present?
      video = presenter.new(video)
    end

    render 'woople-theme/video_modal', video: video
  end

  def content_item_header
    render partial: 'woople-theme/content_item_header'
  end
end
