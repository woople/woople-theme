module ContentImage
  DEFAULT_IMAGE = 'woople-theme/missing.png'
  MISSING_WOOPLE_IMAGE = '/images/original/missing.png'

  def image(&block)
    yield(normalized(__getobj__.image) || DEFAULT_IMAGE) if __getobj__.respond_to? :image
  end

  private

  def normalized(image)
    if image.is_a?(Paperclip::Attachment) && image.to_s == MISSING_WOOPLE_IMAGE
      DEFAULT_IMAGE
    else
      image
    end
  end
end
