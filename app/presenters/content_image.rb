module ContentImage
  DEFAULT_IMAGE        = 'woople-theme/missing.png'
  MISSING_WOOPLE_IMAGE = '/assets/retina_thumb/missing.png'

  def image(&block)
    yield(normalized(__getobj__.image) || DEFAULT_IMAGE) if __getobj__.respond_to? :image
  end

  private

  def normalized(image)
    if image == MISSING_WOOPLE_IMAGE
      DEFAULT_IMAGE
    else
      image
    end
  end
end
