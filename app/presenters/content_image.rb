module ContentImage
  DEFAULT_IMAGE = 'woople-theme/missing.png'

  def image(&block)
    yield(__getobj__.image || DEFAULT_IMAGE) if __getobj__.respond_to? :image
  end
end
