module ThemeHelper

  # This allows you to generate a page-header component
  def page_header(header, presenter = nil)
    #TODO: fix this hack
    if header.is_a? Hash
      header = OpenStruct.new(header)
    end

    if presenter.present?
      header = presenter.new(PageHeaderPresenter.new(header))
    else
      header = PageHeaderPresenter.new(header)
    end

    render 'woople-theme/page_header', header: header
  end

  def content_items(items, presenter = nil)
    if presenter.present?
      collection = items.collect { |item| presenter.new(ContentItemPresenter.new(item)) }
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

  def outline(items, presenter = nil)
    if presenter.present?
      collection = items.collect { |item| presenter.new(OutlinePresenter.new(item)) }
    else
      collection = items.collect { |item| OutlinePresenter.new(item) }
    end

    render partial: 'woople-theme/outline', collection: collection
  end

  def outline_downloads(items, decorator)
    items = items.collect { |item| decorator.decorate_download(item) }

    render partial: 'woople-theme/outline_download', collection: items
  end

  def outline_videos(items, decorator)
    items = items.collect { |item| decorator.decorate_video(item) }

    render partial: 'woople-theme/outline_video', collection: items
  end

  def profile(presenter = nil)
    if presenter.present?
      model = presenter.new(ProfilePresenter.new(profile_links))
    else
      model = ProfilePresenter.new(profile_links)
    end

    render 'woople-theme/profile', profile: ProfilePresenter.new(profile_links)
  end
end
